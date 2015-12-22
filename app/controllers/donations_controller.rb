# app/controllers/donations_controller.rb
class DonationsController < ApplicationController
  before_action :set_recipient, except: [:thanks, :cancel_monthly_donation, :delete, :destroy]

  def show
  end

  def index
  end

  def new
    @donation = @recipient.donations.new
  end

  def create
    @donation = @recipient.donations.build(donation_params)
    @stripe_token = :stripe_token
    if @donation.recurring == true
      if @donation.subscribe_stripe_customer && @donation.save
        DonationMailer.monthly_donation_receipt(@donation).deliver_later
        DonationMailer.donation_received(@donation).deliver_later unless @donation.recipient_type == 'Charity'
        set_session_ids
        redirect_to :thanks
      else
        render :new
      end
    else
      if @donation.create_stripe_charge && @donation.save
        DonationMailer.donation_receipt(@donation).deliver_later
        DonationMailer.donation_received(@donation).deliver_later unless @donation.recipient_type == 'Charity'
        set_session_ids
        redirect_to :thanks
      else
        render :new
      end
    end
  end

  def thanks
    @donation = Donation.find(session[:donation_id])
    if session[:recipient_type] == 'Family'
      @recipient = Family.include_total_raised.find(session[:recipient_id])
    elsif session[:recipient_type] == 'Charity'
      @recipient = Charity.find(session[:recipient_id])
    end
  end

  def edit
    @donation = @recipient.donations.find(params[:id])
  end

  def update
    @donation = @recipient.donations.find(params[:id])
    if @donation.update(donation_params)
      if @donation.recurring == false
        @donation.delete_stripe_customer
        DonationMailer.cancel_monthly_donation_confirmation(@donation).deliver_later
      end
      redirect_to root_url, notice: 'Your donation has been canceled.'
    else
      render :edit
    end
  end

  def delete
  end

  def destroy
  end

  def cancel_monthly_donation
    @donation = Donation.find_by(token: params[:token])
    @recipient = @donation.recipient
  end

  private

  def set_recipient
    if params[:family_id].present?
      @recipient = Family.include_total_raised.find_by_slug!(params[:family_id])
    else
      @recipient = Charity.find(1)
    end
  end

  def set_session_ids
    session[:donation_id] = @donation.id
    session[:recipient_type] = @donation.recipient_type
    session[:recipient_id] = @donation.recipient_id
  end

  def donation_params
    params.require(:donation).permit(
      :recipient_id, :recipient_type, :amount, :at_tip, :name, :anonymous, :message, :email, :at_newsletter, :family_email_updates, :hide_amount, :recurring, :stripe_token
    )
  end
end

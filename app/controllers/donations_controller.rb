# app/controllers/donations_controller.rb
class DonationsController < ApplicationController
  before_action :get_recipient, except: [:delete, :destroy]

  def show
  end

  def index
  end

  def new
    get_recipient
    @donation = Donation.new
  end

  def create
    get_recipient
    @donation = @recipient.donations.build(donation_params)
    @stripe_token = :stripe_token
    if @donation.recurring == false
      if @donation.create_stripe_charge && @donation.save
        get_session_ids
        # send_receipt
        redirect_to :thanks
      else
        render :new
      end
    else
      if @donation.subscribe_stripe_customer && @donation.save
        get_session_ids
        # send_receipt
        redirect_to :thanks
      else
        render :new
      end
    end
  end

  def thanks
    @donation = Donation.find(session[:donation_id])
  end

  def edit
    @donation = @recipient.donations.find(params[:id])
  end

  def update
    get_recipient
    @donation = @recipient.donations.find(params[:id])
    if @donation.update(donation_params)
      if @donation.recurring == false
        @donation.delete_stripe_customer
      end
      redirect_to root_url, notice: 'Your donation has been updated.'
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

  def get_recipient
    if params[:family_id].present?
      @recipient = Family.find(params[:family_id])
    else
      @recipient = Charity.find(1)
    end
  end

  def get_session_ids
    session[:donation_id] = @donation.id
  end

  def donation_params
    params.require(:donation).permit(
      :recipient_id, :recipient_type, :amount, :at_tip, :name, :anonymous, :message, :email, :at_newsletter, :family_email_updates, :hide_amount, :recurring, :stripe_token
    )
  end
end

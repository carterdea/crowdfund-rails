class DonationsController < ApplicationController
  def show
  end

  def index
  end

  def new
    if params[:family_id].nil?
      @family = Family.find(1)
    else
      @family = Family.find(params[:family_id])
    end
    @donation = Donation.new
  end

  def create
    @family = Family.find(params[:family_id])
    @donation = @family.donations.build(donation_params)
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
    @family = Family.find(session[:family_id])
    @donation = Donation.find(session[:donation_id])
  end

  def edit
    @family = Family.find(params[:family_id])
    @donation = @family.donations.find(params[:id])
  end

  def update
    @family = Family.find(params[:family_id])
    @donation = @family.donations.find(params[:id])
    if @donation.update(donation_params)
      if @donation.recurring == false
        @donation.delete_stripe_customer
      end
      redirect_to @family, notice: 'Your donation has been updated.'
    else
      render :edit
    end
  end

  def delete
  end

  def destroy
  end

  def cancel_monthly_donation
    @family = Family.find(params[:family_id])
    @donation = @family.donations.find_by(token: params[:token])
  end

  private

  def get_family
    @family = Family.find(params[:family_id])
  end

  def get_session_ids
    session[:family_id] = @family.id
    session[:donation_id] = @donation.id
  end

  def donation_params
    params.require(:donation).permit(
      :family_id, :amount, :at_tip, :name, :anonymous, :message, :email, :at_newsletter, :family_email_updates, :hide_amount, :recurring, :stripe_token
    )
  end
end

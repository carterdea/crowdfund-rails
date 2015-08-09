class DonationsController < ApplicationController

  def show
  end

  def index
  end

  def new
    if params[:family_id].nil?
      #...
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
        session[:family_id] = @family.id
        session[:donation_id] = @donation.id
        # send_receipt
        redirect_to :thanks
      else
        render :new
      end
    else
      if @donation.subscribe_stripe_customer && @donation.save
        session[:family_id] = @family.id
        session[:donation_id] = @donation.id
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

  def delete
  end

  def destroy
  end

private
  def donation_params
    params.require(:donation).permit(
      :family_id,
      :amount,
      :at_tip,
      :name,
      :anonymous,
      :message,
      :email,
      :at_newsletter,
      :family_email_updates,
      :hide_amount,
      :recurring,
      :stripe_token
    )
  end
end

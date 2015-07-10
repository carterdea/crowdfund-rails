class DonationsController < ApplicationController

  def show
  end

  def index
  end

  def new
    @family = Family.find(params[:family_id])
    @donation = Donation.new
  end

  def create
    @family = Family.find(params[:family_id])
    @donation = @family.donations.build(donation_params)
    @stripe_token = :stripe_token
    if @donation.recurring == false
      if @donation.create_stripe_charge && @donation.save
        redirect_to @family, notice: "Thanks so much for your generous donation!"
      else
        render :new
      end
    else
      if @donation.create_stripe_customer && @donation.save
        @donation.charge_stripe_customer
        redirect_to @family, notice: "Thanks so much for your generous **recurring** donation!"
      else
        render :new
      end
    end
  end

  def thanks
  end

  def edit
    @family = Family.find(params[:family_id])
    @donation = @family.donations.build(donation_params)
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

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
    if params[:family_id].present?
      @family = Family.find(params[:family_id])
      @donation = @family.donations.build(donation_params)
      if @donation.save
        redirect_to @family, notice: "Thanks so much for your generous donation!"
      else
        render :new
      end
    else
      @family = nil
      @donation = Donation.new(donation_params)
      if @donation.save
        redirect_to root_url, notice: "Thanks so much for your generous donation!"
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
    params.require(:donation).permit(:family_id, :amount, :at_tip, :name, :anonymous, :message, :email, :at_newsletter, :family_email_updates, :hide_amount, :recurring)
  end

end

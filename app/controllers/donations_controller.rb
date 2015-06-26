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
    else
      @family = nil
    end
    @donation = @family.donations.build(donation_params)
  end

  def edit
    @family = Family.find(params[:family_id])
    @donation = @family.donations.build(donation_params)
  end

private
  def donation_params
    params.require(params).require(:family_id, :amount, :recurring, :at_tip, :privacy, :message, :name, :email, :newsletter)
  end

end

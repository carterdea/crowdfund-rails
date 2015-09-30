class Admin::DonationsController < ApplicationController
  load_and_authorize_resource

  def index
    if params[:family_id]
      @family = Family.find_by_slug!(params[:family_id])
      @donations = @family.donations.all.order('created_at DESC').page(params[:page]).per(30)
    else
      @donations = Donation.all.order('created_at DESC').page(params[:page]).per(30)
    end
  end

  def edit
    @donation = Donation.find(params[:id])
    @recipient = @donation.recipient
  end

  def update
  end

end

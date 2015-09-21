class Admin::DonationsController < ApplicationController
  load_and_authorize_resource

  def index
    if params[:family_id]
      @family = Family.find_by_slug!(params[:family_id])
      @donations = @family.donations.all.page(params[:page]).per(30)
    else
      @donations = Donation.all.page(params[:page]).per(30)
    end
  end

end

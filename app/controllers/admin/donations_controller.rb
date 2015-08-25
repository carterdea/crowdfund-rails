class Admin::DonationsController < ApplicationController
  load_and_authorize_resource

  def index
    @donations = Donation.all.page(params[:page]).per(30)
  end

end

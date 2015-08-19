class Admin::DonationsController < ApplicationController
  def index
    @donations = Donation.all.page(params[:page]).per(30)
  end

end

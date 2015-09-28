class Admin::CharitiesController < ApplicationController
  load_and_authorize_resource

  def index
    @donations = Donation.all.page(params[:page]).per(30)
  end

  def show
    @charity = Charity.find(params[:id])
    @donations = @charity.donations
    render "admin/donations/index"
  end
end

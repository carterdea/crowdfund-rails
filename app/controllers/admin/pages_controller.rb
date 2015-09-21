class Admin::PagesController < ApplicationController
  authorize_resource :class => false

  def dashboard
    @families = Family.select(:id, :photo, :first_name, :last_name, :country).includes(:donations).page(params[:page]).per(30)
    @donations = Donation.select(:amount, :recipient, :recipient_type)
  end

  def index
  end

  def new
  end

  def edit
  end

  def update
  end

  def delete
  end

  def destroy
  end
end
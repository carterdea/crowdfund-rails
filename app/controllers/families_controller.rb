class FamiliesController < ApplicationController
  before_action :require_login, only: [:edit, :update, :destroy]

  def index
    @families = Family.all
  end

  def show
    @family = Family.find(params[:id])
  end

  def new
    @family = Family.new
  end

  def create
    @family = Family.new(family_params)
    if @family.save
      redirect_to @family, notice: "Thanks for setting up your family profile! We'll look it over and be in touch shortly."
    else
      flash.now[:alert] = "There was a problem with your family profile. Please check it and try again."
      render :new
    end
  end

  def edit
    @family = Family.find(params[:id])
  end

  def update
    @family = Family.find(params[:id])
    if @family.update(family_params)
      redirect_to @family, notice: "Your family profile has been updated."
    else
      render :edit
    end
  end

  def destroy
    @family.destroy
    redirect_to root_url, alert: "Your family profile has successfully been deleted. We're sorry to see you go."
  end

private
  def family_params
    params.require(:family).permit(:first_name, :last_name, :phone, :postal_code, :cost, :fixnum, :country, :gender, :quantity, :description, :status, :agency_name, :agency_site, :photo)
  end

end

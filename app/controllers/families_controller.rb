class FamiliesController < ApplicationController
  before_action :require_login, only: [:edit, :update, :destroy]
  # before_action :require_correct_user, only: [:edit, :update, :destroy]

  def index
    @families = Family.all.page(params[:page]).per(30)
  end

  def search
    if params[:q].present?
      @families = Family.search(params[:q]).records.page(params[:page]).per(30)
      render action: "index"
    else
      redirect_to families_path
    end
  end

  def show
    @family = Family.find(params[:id])
    @donations = @family.donations.order("id DESC").page(params[:page]).per(10)
  end

  def new
    @family = Family.new
  end

  def create
    if current_user
      @user = current_user
    else
      @user = User.new(user_params)
    end
    @family = @user.families.build(family_params)
    if @user.valid? && @family.valid?
      @user.save unless current_user
      @family.save
      login(user_params[:email], user_params[:password])

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
    params.require(:family).permit(:first_name, :last_name, :phone, :postal_code, :cost, :country, :gender, :quantity, :description, :status, :agency_name, :agency_site, :photo)
  end

  def require_correct_user
    @family = Family.find(params[:id])
    unless current_user(@user)
      redirect_to root_path, notice: "Sorry, you don't have permission to do that."
    end
  end

end

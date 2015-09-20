class FamiliesController < ApplicationController
  before_filter :set_family, only: [:edit, :show, :update, :approval_letter]
  load_and_authorize_resource
  before_action :require_login, only: [:edit, :update, :destroy, :approval_letter]

  def index
    @families = Family.select(:id, :photo, :first_name, :last_name, :country).page(params[:page]).per(30)
  end

  def search
    if params[:q].present?
      @families = Family.search(params[:q]).records.page(params[:page]).per(30)
      render action: 'index'
    else
      redirect_to families_path
    end
  end

  def show
    @donations = @family.donations.order('id DESC').page(params[:page]).per(10)
    @updates = @family.updates.page(params[:page]).per(5)
  end

  def new
    @user = User.new unless current_user
    @family = Family.new
  end

  def create
    if current_user
      @user = current_user
      @family = @user.build_family(family_params)
      if @family.save
        redirect_to @family, notice: 'Your family profile is now live! Share it with friends to start raising funds for your adoption.'
      else
        flash.now[:alert] = 'There was a problem with your family profile. Please check it and try again.'
        render :new
      end
    else
      @user = User.new(user_params)
      @family = @user.build_family(family_params)
      if @user.valid? && @family.valid?
        @user.save unless current_user
        @family.save
        login(user_params[:email], user_params[:password])

        redirect_to @family, notice: 'Your family profile is now live! Share it with friends to start raising funds for your adoption.'
      else
        flash.now[:alert] = 'There was a problem with your family profile. Please check it and try again.'
        render :new
      end
    end
  end

  def edit
  end

  def approval_letter
  end

  def update
    if @family.update(family_params)
      redirect_to @family, notice: 'Your family profile has been updated.'
    else
      render :edit
    end
  end

  def destroy
    @family.destroy
    redirect_to root_url, alert: 'Your family profile has successfully been deleted. We\'re sorry to see you go.'
  end

  private

  def set_family
    @family = Family.find_by_slug!(params[:id])
  end

  def family_params
    params.require(:family).permit(:first_name, :last_name, :phone, :postal_code, :user_cost, :country, :gender, :quantity, :description, :status, :agency_name, :agency_site, :photo, :approval_letter_file, :slug)
  end
end

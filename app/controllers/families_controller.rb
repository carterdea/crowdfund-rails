class FamiliesController < ApplicationController
  before_action :set_family, only: [:edit, :show, :update, :approval_letter]

  load_and_authorize_resource
  before_action :require_login, only: [:edit, :update, :destroy, :approval_letter]

  def index
    @families = Family.approved.visible.include_total_raised.select(:id, :photo, :first_name, :last_name, :country, :slug).order('families.created_at DESC').page(params[:page]).per(30)
  end

  def search
    if params[:q].present?
      @families = Family.approved.visible.search(params[:q]).records.include_total_raised.page(params[:page]).per(30)
      render :index
    else
      redirect_to families_path
    end
  end

  def show
    @donations = @family.donations.order('id DESC').page(params[:page]).per(10)
    @updates = @family.updates.order('created_at DESC').page(params[:page]).per(5)
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
        FamilyMailer.new_family_email(@family).deliver_later
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
        FamilyMailer.new_family_email(@family).deliver_later
        redirect_to family_path(@family), notice: 'Your family profile is now live! Share it with friends to start raising funds for your adoption.'
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
      if Rails.application.routes.recognize_path(request.referer)[:action] == 'approval_letter' ## If the user is coming to Families#Update from 'Approval Letter', send them back to Grants#Update
        redirect_to family_grants_path(@family), notice: 'Thanks for uploading your approval letter! We\'ll take a look at it and get back to you soon.'
      else
        redirect_to @family, notice: 'Your family profile has been updated.'
      end
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
    if params[:id]
      @family = Family.include_total_raised.find_by_slug!(params[:id])
    elsif params[:family_id]
      @family = Family.include_total_raised.find_by_slug!(params[:family_id])
    end
  end

  def family_params
    params.require(:family).permit(:first_name, :last_name, :phone, :address, :city, :state, :postal_code, :user_cost, :country, :gender, :quantity, :description, :status, :agency_name, :agency_site, :photo, :approval_letter_file, :slug)
  end
end

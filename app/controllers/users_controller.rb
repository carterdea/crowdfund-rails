# app/controllerrs/users_controller.rb
class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :require_login, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:edit, :update]

  def index
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(user_params[:email], user_params[:password])
      redirect_to root_url, notice: 'Thanks for signing up!'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @family = @user.family
    if @user.update(user_params)
      redirect_to @family, notice: 'Your user account has been updated.'
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, authentications_attributes: [:user_id, :provider, :uid])
  end
end

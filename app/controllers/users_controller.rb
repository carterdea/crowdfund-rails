# app/controllerrs/users_controller.rb
class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :require_login, only: [:edit, :update, :destroy]

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
      UserMailer.welcome(@user).deliver_now
      redirect_to root_url, notice: 'Thanks for signing up!'
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, authentications_attributes: [:user_id, :provider, :uid])
  end
end

class UsersController < ApplicationController
  before_filter :require_login, only: [:edit, :update, :destroy]
  
  def index
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user= User.new(user_params)
    if @user.save
      redirect_to root_url, notice: "Thanks for signing up!"
    else
      render :new
    end
  end

  def edit
    @user = User.find_by(params[:id])
  end

  def update
  end

  def destroy
  end

private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end

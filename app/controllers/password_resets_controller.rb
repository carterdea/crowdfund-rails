class PasswordResetsController < ApplicationController
  def index
    render :new
  end

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_reset_password_instructions!
      redirect_to root_path, notice: 'A link to reset your password has been sent to your email.'
    else
      flash.now.alert = 'Sorry, we cant find an account with that email. Try another email or sign up.'
      render :new
    end
  end

  def edit
    get_token_and_user
    do_not_authenticate_blank_user
  end

  def update
    get_token_and_user
    do_not_authenticate_blank_user
    params[:user][:password_confirmation] = params[:user][:password]
    if @user.change_password!(params[:user][:password])
      auto_login(@user)
      redirect_to dashboard_path, notice: 'Password was successfully updated.'
    else
      render :edit
    end
  end

  private

  def get_token_and_user
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
  end

  def do_not_authenticate_blank_user
    not_authenticated if @user.blank?
  end
end

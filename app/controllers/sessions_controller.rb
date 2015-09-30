class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = login(params[:email], params[:password])
    if user
      redirect_back_or_to dashboard_url, notice: 'You are now logged in!'
    else
      flash.now.alert = 'Email or password was invalid. Try again.'
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, notice: 'You are now logged out.'
  end
end

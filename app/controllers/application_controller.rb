class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def not_authenticated
    redirect_to login_url, notice: 'You need to be logged in to do this.'
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

  rescue_from CanCan::AccessDenied do |exception|
    if current_user.nil?
      redirect_to login_url, notice: 'You need to be logged in to do this.'
    else
      redirect_to root_url, alert: exception.message
    end
  end
end

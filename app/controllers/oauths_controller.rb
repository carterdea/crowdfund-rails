class OauthsController < ApplicationController
  skip_before_filter :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params
    if @user = login_from(provider)
      redirect_back_or_to dashboard_url, notice: "Logged in with #{provider.titleize}"
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        redirect_back_or_to dashboard_path, notice: "Logged in with #{provider.titleize}"
      rescue
        redirect_back_or_to root_path, alert: "Failed to login with #{provider.titleize}"
      end
    end
  end

private
  def auth_params
    params.permit(:provider, :code)
  end
end

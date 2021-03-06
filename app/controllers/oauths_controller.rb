class OauthsController < ApplicationController
  skip_before_filter :require_login

  def oauth
    session[:return_to_url] = request.referer unless request.referer =~ /oauth/
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if @user = login_from(provider)
      redirect_back_or_to root_path, :notice => "Logged in with #{provider.titleize}"
    else
      begin
        @user = create_from(provider)
        family_params = @user_hash
        @family = @user.families.create(family_params)
        reset_session
        auto_login(@user)
        redirect_back_or_to root_path, :notice => "Signed up with #{provider.titleize}"
      rescue
        redirect_back_or_to root_path, :alert => "Failed to login from #{provider.titleize}"
      end
    end
  end

private
  def auth_params
    params.permit(:provider, :code)
  end
end

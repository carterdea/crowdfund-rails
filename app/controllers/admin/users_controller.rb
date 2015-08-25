class Admin::UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.all.page(params[:page]).per(30)
  end

end

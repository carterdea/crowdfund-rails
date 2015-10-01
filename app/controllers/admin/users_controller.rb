class Admin::UsersController < ADMIN::AdminController
  load_and_authorize_resource

  def index
    @users = User.all.order(sort_column + ' ' + sort_direction).page(params[:page]).per(30)
  end
end

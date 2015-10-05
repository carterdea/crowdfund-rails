class Admin::UsersController < ADMIN::AdminController
  load_and_authorize_resource

  def index
    @users = User.all.order(sort_column + ' ' + sort_direction).page(params[:page]).per(30)
    respond_to do |format|
      format.html
      format.csv { send_data User.to_csv, filename: "users-#{Date.today}.csv" }
      format.xls { send_data User.to_csv(col_sep: "\t"), filename: "users-#{Date.today}.xls" }
    end
  end
end

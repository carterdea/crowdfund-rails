class Admin::FamiliesController < ADMIN::AdminController
  before_filter :set_family, only: [:toggle_approval, :toggle_visibility]

  load_and_authorize_resource

  def index
    @families = Family.include_total_raised.includes(:user).order(sort_column + ' ' + sort_direction).page(params[:page]).per(30)
    respond_to do |format|
      format.html
      format.csv { send_data Family.to_csv, filename: "families-#{Date.today}.csv" }
      format.xls { send_data Family.to_csv(col_sep: "\t"), filename: "families-#{Date.today}.xls" }
    end
  end

  def search
    if params[:q].present?
      @families = Family.approved.visible.search(params[:q]).records.include_total_raised.page(params[:page]).per(30)
      render :index
    else
      redirect_to admin_families_path
    end
  end

  def toggle_approval
    @family.toggle!(:approved)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def toggle_visibility
    @family.toggle!(:visible)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  private

  def set_family
    if params[:id]
      @family = Family.include_total_raised.find_by_slug!(params[:id])
    elsif params[:family_id]
      @family = Family.include_total_raised.find_by_slug!(params[:family_id])
    end
  end

  def family_params
    params.require(:family).permit(:first_name, :last_name, :phone, :address, :city, :state, :postal_code, :user_cost, :country, :gender, :quantity, :description, :status, :agency_name, :agency_site, :photo, :approval_letter_file, :slug)
  end
end

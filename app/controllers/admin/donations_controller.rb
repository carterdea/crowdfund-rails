class Admin::DonationsController < ADMIN::AdminController
  load_and_authorize_resource

  def index
    if params[:family_id]
      @family = Family.find_by_slug!(params[:family_id])
      @donations = @family.donations.all.order(sort_column + ' ' + sort_direction).page(params[:page]).per(30)
    else
      @donations = Donation.all.order(sort_column + ' ' + sort_direction).page(params[:page]).per(30)
      respond_to do |format|
        format.html
        format.csv { send_data Donation.to_csv, filename: "donations-#{Date.today}.csv" }
        format.xls { send_data Donation.to_csv(col_sep: "\t"), filename: "donations-#{Date.today}.xls" }
      end
    end
  end

  def edit
    @donation = Donation.find(params[:id])
    @recipient = @donation.recipient
  end

  def update
  end
end

class Admin::PagesController < ADMIN::AdminController
  authorize_resource class: false

  def dashboard
    @families = Family.include_total_raised.select(:id, :photo, :first_name, :last_name, :country).page(params[:page]).per(30)
    # @donations = Donation.select(:amount, :recipient, :recipient_type)
    @family_donations = Donation.all
  end

  def index
    @pages = Page.all.page(params[:page]).per(30)
  end

  def show
    @page = Page.find_by_slug(params[:id])
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      redirect_to root_url + @page.slug, notice: "The page #{@page.title} has been successfully created 👌"
    else
      render :new
    end
  end

  def edit
    @page = Page.find_by_slug(params[:id])
  end

  def update
    @page = Page.find_by_slug(params[:id])
    if @page.update(page_params)
      redirect_to root_url + @page.slug, notice: "The page #{@page.title} has been successfully updated 😉"
    else
      render :edit
    end
  end

  def delete
  end

  def destroy
  end

  private

  def page_params
    params.require(:page).permit(:title, :body, :slug, :created_by, :seo_title, :seo_description, :live)
  end
end
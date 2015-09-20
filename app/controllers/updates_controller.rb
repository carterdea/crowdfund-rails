class UpdatesController < ApplicationController
  load_and_authorize_resource
  before_action :set_family

  def index
    @updates = @family.updates.all.page(params[:page]).per(15)
  end

  def show
    @update = @family.updates.find(params[:id])
  end

  def new
    @update = @family.updates.new
  end

  def create
    @update = @family.updates.new(update_params)
    if @update.save
      redirect_to family_updates_path(@family), notice: 'Thanks so much for updating your donors!'
    else
      render :new
    end
  end

  def edit
    @update = @family.updates.find(params[:id])
  end

  def update
    @update = @family.updates.find(params[:id])
    if @update.update(update_params)
      redirect :show, notice: 'Your update has been edited successfully.'
    else
      render :new
    end
  end

  def destroy
    @update = @family.updates.find(params[:id])
    @update.destroy
    redirect_to updates_path, alert: 'Your update has been deleted.'
  end

private
  def update_params
    params.require(:update).permit(:title, :message, :on_profile, :email_donors)
  end

  def set_family
    @family = Family.find_by_slug!(params[:family_id])
  end
end

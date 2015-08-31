class Admin::FamiliesController < ApplicationController
  load_and_authorize_resource

  def index
    @families = Family.includes(:donations, :grants).select(:id, :first_name, :last_name, :photo, :approved, :created_at).page(params[:page]).per(30)
  end

  def search
    if params[:q].present?
      @families = Family.search(params[:q]).records.includes(:donations, :grants).page(params[:page]).per(30)
      render action: 'index'
    else
      redirect_to admin_families_path
    end
  end

  def toggle_approval
    @family = Family.find(params[:id])
    @family.toggle_approval
    redirect_to(:back)
  end
end

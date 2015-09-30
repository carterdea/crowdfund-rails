class Admin::FamiliesController < ApplicationController
  before_filter :set_family, only: [:toggle_approval, :toggle_visibility]

  load_and_authorize_resource

  def index
    @families = Family.includes(:user).order('created_at DESC').page(params[:page]).per(30)
  end

  def search
    if params[:q].present?
      @families = Family.search(params[:q]).records.page(params[:page]).per(30)
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
    @family = Family.find_by_slug!(params[:id])
  end
end

class Admin::FamiliesController < ApplicationController
  def index
    @families = Family.all.page(params[:page]).per(30)
  end

  def toggle_approval
    @family = Family.find(params[:id])
    @family.toggle_approval
    redirect_to(:back)
  end
end

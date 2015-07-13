class Admin::FamiliesController < ApplicationController
  def index
    @families = Family.all.page(params[:page]).per(30)
  end

  def new
  end

  def edit
  end

  def update
  end

  def delete
  end

  def destroy
  end
end

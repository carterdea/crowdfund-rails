class GrantsController < ApplicationController
  def index
    @family = Family.find(params[:family_id])
    @grants = @family.grants.all
  end

  def new
    @family = Family.find(params[:family_id])
    @grant = @family.grants.new
  end

  def create
    @family = Family.find(params[:family_id])
    @grant = @family.grants.build(grants_params)
    if @grant.save
      redirect_to family_grants_path(@family), notice: 'Thanks for requesting a grant! We\'ll get back to you soon'
    else
      render :new
    end
  end

  def edit
    @family = Family.find(params[:family_id])
    @grant = @family.grants.find(params[:id])
  end

  def update
  end

  def delete
  end

  def destroy
  end

  private

  def grants_params
    params.require(:grant).permit(:family_id, :amount_requested, :expense_description, :requested_to_name, :requested_to_address, :requested_to_city, :requested_to_state, :requested_to_zip, :signature)
  end
end

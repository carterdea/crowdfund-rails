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
    params.require(:grants).permit(:family_id, :amount_requested, :expense_description, :requested_to_name, :requested_to_address, :requested_to_city, :requested_to_state, :requested_to_zip, :signature)
  end

end

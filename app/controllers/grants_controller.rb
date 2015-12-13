class GrantsController < ApplicationController
  before_filter :set_family, only: [:index, :new, :create, :edit, :update]

  load_and_authorize_resource :family
  load_and_authorize_resource :grant, through: :family
  before_action :require_login

  def index
    @grants = @family.grants.all.page(params[:page]).per(10)
    authorize! :manage, @family
  end

  def new
    @grant = @family.grants.new
  end

  def create
    @grant = @family.grants.build(grant_params)
    if @grant.save
      GrantMailer.grant_request_received(@grant).deliver_later
      redirect_to family_grants_path(@family), notice: 'Thanks for requesting a grant! We\'ll get back to you soon'
    else
      render :new
    end
  end

  def edit
    @grant = @family.grants.find(params[:id])
  end

  def update
  end

  def delete
  end

  def destroy
  end

  private

  def set_family
    @family = Family.find_by_slug!(params[:family_id])
  end

  def grant_params
    params.require(:grant).permit(:family_id, :user_amount_requested, :amount_requested, :supporting_documentation, :expense_description, :requested_to_name, :requested_to_address, :requested_to_city, :requested_to_state, :requested_to_zip, :signature)
  end
end

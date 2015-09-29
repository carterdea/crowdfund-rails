class Admin::GrantsController < ApplicationController
  load_and_authorize_resource
  before_action :set_grant, only: [:edit, :show, :update]

  def index
    @grants = Grant.all.page(params[:page]).per(30).order('created_at asc')
    @family = Family.find_by_slug!(params[:family_id]) if params[:family_id]
  end

  def show
    @family = @grant.family
  end

  def update
    if @grant.update(grant_params)
      @grant.status = 'approved'
      @grant.save
      GrantMailer.grant_request_approved(@grant).deliver_now
      redirect_to admin_grant_path(@grant), notice: "You have approved this grant for $#{@grant.amount_approved}! 🎉"
    else
      render :show
    end
  end

  def grant_denied
    @grant = Grant.find(params[:grant_id])
    @grant.status = 'denied'
    if @grant.save
      GrantMailer.grant_request_denied(@grant).deliver_now
      redirect_to admin_grant_path(@grant), notice: 'You have denied this grant. 😔'
    else
      render :show, notice: 'I have no idea what happened, but email me and I\'ll figure it out. <3 Carter'
    end
  end

  private

  def set_grant
    @grant = Grant.find(params[:id])
  end

  def grant_params
    params.require(:grant).permit(:family_id, :user_amount_requested, :amount_requested, :amount_approved, :supporting_documentation, :expense_description, :requested_to_name, :requested_to_address, :requested_to_city, :requested_to_state, :requested_to_zip, :signature)
  end
end

class ADMIN::AdminController < ApplicationController
  helper_method :sort_column, :sort_direction

  private

  def sort_column
    controller_name.classify.constantize.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
  end

  def sort_direction
    %w(asc desc).include?(params[:direction]) ? params[:direction] : 'desc'
  end

  def sort_params
    params.require(controller_name.to_sym).permit(:sort, :direction)
  end
end

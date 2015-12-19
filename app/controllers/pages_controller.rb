class PagesController < ApplicationController
  before_action :require_login, only: :dashboard

  def home
    @families = Family.approved.visible.include_total_raised.limit(9)
    @posts = Page.tumblr_posts
  end

  def dashboard
    @family = Family.include_total_raised.includes(:donations, :updates).find_by(user_id: current_user.id) if current_user.family?
  end

  def about
  end

  # TODO according to the UX doc here: http://cl.ly/bjD8
  # def how_it_works
  # end

  def faq
  end

  def contact
  end

  # def press
  # end

  # def help
  # end

  # def privacy
  # end

  # def terms
  # end

  # when a user unsubscribes show them this page
  # def unsub
  # end

  def show
  end
end

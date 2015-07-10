class PagesController < ApplicationController
  before_action :require_login, only: :dashboard

  def home
    @families = Family.all.limit(9)
  end

  def dashboard
    @family = Family.find_by(user_id: current_user.id)
    @donations = @family.donations.all
  end

  # TODO according to the UX doc here: http://cl.ly/bjD8
  # def what_is_adopttogether
  # end

  # def how_it_works
  # end

  # def about_us
  # end

  # def faq
  # end

  # def contact
  # end

  # def press
  # end

  # def help
  # end

  # def privacy
  # end

  # def terms
  # end
end

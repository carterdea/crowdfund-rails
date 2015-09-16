class FamilyMailer < ApplicationMailer
  def welcome_family(family)
    @family = family
    @user = family.user
    mail(to: @user.email, subject: 'Welcome to AdoptTogether')
  end

  def start_fundraising
  end

  def fully_funded
  end

  def grant_receieved
  end

  def grant_approved
  end
end

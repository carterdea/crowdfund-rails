class FamilyMailer < ApplicationMailer
  def new_family_email(family)
    @family = family
    @user = family.user

    subject = 'Your AdoptTogether Profile is Live!'

    merge_vars = {
      'FIRST_NAME' => @family.first_name,
      'FAMILY_URL' => family_url(@family)
    }

    body = mandrill_template('new-family', merge_vars)

    send_mail(@user.email,
              subject,
              body)
  end

  def start_fundraising
  end

  def fully_funded
  end

  def approval_letter_received
  end

  def grant_received
  end

  def grant_approved
  end
end

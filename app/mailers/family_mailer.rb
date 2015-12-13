class FamilyMailer < ApplicationMailer
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::TextHelper
  include DonationsHelper

  def new_family_email(family)
    @family = family
    @user = family.user

    subject = 'Your AdoptTogether Profile is Live!'

    merge_vars = {
      'FIRST_NAME' => @family.first_name,
      'LAST_NAME' => @family.last_name,
      'FAMILY_PROFILE_URL' => family_url(@family),
      'FAMILY_PROFILE_URL_PARAMETERIZED' => family_url(@family).to_param,
      'TOTAL_RAISED' => pretty_dollars(family.donations.pluck(:amount).sum),
      'ADOPTION_COUNTRY' => @family.country,
      'FAMILY_PHOTO_URL' => root_url + @family.photo.large.url,
      'FAMILY_UPDATES_URL' => family_updates_url(@family),
      'FAMILY_GRANTS_URL' => family_grants_url(@family)
    }

    body = mandrill_template('new-family', merge_vars)

    send_mail(@user.email,
              subject,
              body)
  end

  def start_fundraising
  end

  def fully_funded(family)
    @family = family
    @user = family.user

    subject = 'Your AdoptTogether Profile is Fully Funded!'

    merge_vars = {
      'FIRST_NAME' => @family.first_name,
      'FAMILY_URL' => family_url(@family)
    }

    body = mandrill_template('family-fully-funded', merge_vars)

    send_mail(@user.email,
              subject,
              body)
  end

  def approval_letter_received
    family = family
    user = family.user

    subject = 'Your Approval Letter has been received!'

    merge_vars = {
      'FIRST_NAME' => family.first_name,
      'FAMILY_URL' => family_url(family)
    }

    body = mandrill_template('family-approval-letter-received', merge_vars)

    send_mail(user.email,
              subject,
              body)
  end
end

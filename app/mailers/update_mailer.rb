class UpdateMailer < ApplicationMailer
  include ActionView::Helpers::TextHelper

  def family_update(update, family)
    @family = family
    @update = update
    email_receivers = @family.donations.pluck(:email)

    subject = "Update from #{@family.full_name}: #{@update.title}"

    merge_vars = {
      'FAMILY_FULL_NAME' => @family.full_name,
      'UPDATE_TITLE' => @update.title,
      'UPDATE_BODY' => simple_format(@update.message),
      'UPDATE_PHOTO' => @update.photo,
      'UPDATE_NUMBER' => @update.sequential_id,
      'UPDATE_CREATED_AT' => @update.created_at,
      'FAMILY_URL' => family_url(@family)
    }

    body = mandrill_template('family-update', merge_vars)

    send_mail(email_receivers,
              subject,
              body)
  end
end

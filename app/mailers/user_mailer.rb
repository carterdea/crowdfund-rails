class UserMailer < ApplicationMailer
  def reset_password_email(user)
    user = User.find(user.id)
    reset_url = edit_password_reset_url(user.reset_password_token)

    subject = 'Resetting your password on AdoptTogether'

    merge_vars = { 'RESET_URL' => reset_url }

    body = mandrill_template('reset-password', merge_vars)

    send_mail(user.email,
              subject,
              body)
  end
end

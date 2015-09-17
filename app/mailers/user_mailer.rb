class UserMailer < ApplicationMailer
  def reset_password_email(user)
    @user = User.find(user.id)
    @url  = edit_password_reset_url(@user.reset_password_token)
    merge_vars = { url: @url,
                   email: @user.email }
    
    body = mandrill_template('reset-password', merge_vars)
    send_mail(@user.email,
              'Resetting your password on AdoptTogether',
              body)
  end
end

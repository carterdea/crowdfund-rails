class GrantMailer < ApplicationMailer
  def grant_request_received(grant)
    family = grant.family
    user = family.user

    subject = 'Your Grant Request has been Received'

    merge_vars = {
      'FIRST_NAME' => family.first_name,
      'AMOUNT_REQUESTED' => grant.amount_requested,
      'EXPENSE_DESCRIPTION' => grant.expense_requested,
      'REQUESTED_TO_NAME' => grant.requested_to_name
    }

    body = mandrill_template('family-fully-funded', merge_vars)

    send_mail(@user.email,
              subject,
              body)
  end

  def grant_request_approved(grant)
  end

  def grant_request_declined(grant)
  end
end

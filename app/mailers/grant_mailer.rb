class GrantMailer < ApplicationMailer
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::TextHelper
  include DonationsHelper

  def grant_request_received(grant)
    family = grant.family
    user = family.user

    subject = 'Your Grant Request has been Received'

    merge_vars = {
      'FIRST_NAME' => family.first_name,
      'AMOUNT_REQUESTED' => pretty_dollars(grant.amount_requested),
      'EXPENSE_DESCRIPTION' => simple_format(grant.expense_description),
      'REQUESTED_TO_NAME' => grant.requested_to_name
    }

    body = mandrill_template('grant-request-received', merge_vars)

    send_mail(user.email,
              subject,
              body)
  end

  def grant_request_approved(grant)
    family = grant.family
    user = family.user

    subject = 'Your Grant Request has been Approved!'

    merge_vars = {
      'FIRST_NAME' => family.first_name,
      'AMOUNT_REQUESTED' => pretty_dollars(grant.amount_requested),
      'AMOUNT_APPROVED' => pretty_dollars(grant.amount_approved),
      'EXPENSE_DESCRIPTION' => simple_format(grant.expense_description),
      'REQUESTED_TO_NAME' => grant.requested_to_name
    }

    body = mandrill_template('grant-request-approved', merge_vars)

    send_mail(user.email,
              subject,
              body)
  end

  def grant_request_declined(grant)
    family = grant.family
    user = family.user

    subject = 'Your Grant Request has been Received'

    merge_vars = {
      'FIRST_NAME' => family.first_name,
      'AMOUNT_REQUESTED' => pretty_dollars(grant.amount_requested),
      'EXPENSE_DESCRIPTION' => simple_format(grant.expense_description),
      'REQUESTED_TO_NAME' => grant.requested_to_name
    }

    body = mandrill_template('grant-request-declined', merge_vars)

    send_mail(user.email,
              subject,
              body)
  end
end

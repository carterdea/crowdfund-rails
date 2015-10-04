class DonationMailer < ApplicationMailer
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::TextHelper
  include DonationsHelper

  def donation_receipt(donation)
    recipient = donation.recipient
    first_name = donation.name.split(' ')[0]

    subject = 'Thank you for your Donation to AdoptTogether'

    merge_vars = {
      'FIRST_NAME' => first_name,
      'AMOUNT' => pretty_dollars(donation.amount),
      'AT_TIP' => pretty_dollars(donation.at_tip),
      'TOTAL' => pretty_dollars(donation.amount + donation.at_tip),
      'RECIPIENT_LAST_NAME' => recipient.last_name
    }

    body = mandrill_template('donation-receipt', merge_vars)

    send_mail(donation.email,
              subject,
              body)
  end

  def monthly_donation_receipt(donation)
    recipient = donation.recipient
    first_name = donation.name.split(' ')[0]
    cancel_monthly_donation_url = cancel_url(recipient, donation)

    subject = 'Thank you for your Monthly Donation to AdoptTogether'

    merge_vars = {
      'FIRST_NAME' => first_name,
      'AMOUNT' => pretty_dollars(donation.amount),
      'AT_TIP' => pretty_dollars(donation.at_tip),
      'TOTAL' => pretty_dollars(donation.amount + donation.at_tip),
      'RECIPIENT_LAST_NAME' => recipient.last_name,
      'CANCEL_MONTHLY_DONATION_BOTTLE' => cancel_monthly_donation_url
    }

    body = mandrill_template('monthly-donation-receipt', merge_vars)

    send_mail(donation.email,
              subject,
              body)
  end

  def send_monthly_donations(email)
    # sends the user all of their active monthly donations so they can cancel them if they so choose
    donations = Donation.where(reccurring == 'true').find_by_email(email)
  end

  def cancel_monthly_donation_confirmation(donation)
    recipient = donation.recipient
    first_name = donation.name
    donation.name.split(' ')[0]

    subject = 'Thank you for your Monthly Donation to AdoptTogether'

    merge_vars = {
      'FIRST_NAME' => first_name,
      'RECIPIENT_NAME' => recipient.full_name
    }

    body = mandrill_template('cancel-monthly-donation-confirmation', merge_vars)

    send_mail(donation.email,
              subject,
              body)
  end

  def donation_received(donation)
    recipient = donation.recipient
    donor_name = donation.name
    exclamation = %w(Yipee Hooray Yay Yahoo).sample
    subject = "#{exclamation}! #{donor_name} donated to your Adoption on AdoptTogether"

    merge_vars = {
      'DONOR_NAME' => donor_name,
      'AMOUNT' => pretty_dollars(donation.amount),
      'MONTHLY' => donation.recurring,
      'MESSAGE' => simple_format(donation.message),
      'RECIPIENT_FIRST_NAME' => recipient.first_name
    }

    body = mandrill_template('donation-received', merge_vars)

    send_mail(recipient.user.email,
              subject,
              body)
  end
end

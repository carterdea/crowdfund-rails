class DonationMailer < ApplicationMailer
  include ActionView::Helpers::NumberHelper
  include DonationsHelper

  def donation_receipt(donation)
    @donation = donation
    recipient = @donation.recipient
    first_name = @donation.name.split(" ")[0]

    subject = 'Thank you for your Donation to AdoptTogether'

    merge_vars = {
      'FIRST_NAME' => first_name,
      'AMOUNT' => pretty_dollars(@donation.amount),
      'AT_TIP' => pretty_dollars(@donation.at_tip),
      'TOTAL' => pretty_dollars(@donation.amount + @donation.at_tip),
      'RECIPIENT_NAME' => recipient.full_name
    }

    body = mandrill_template('donation-receipt', merge_vars)

    send_mail(@donation.email,
              subject,
              body)
  end

  def monthly_receipt
  end

  def send_monthly(email)
    # sends the user all of their active monthly donations so they can cancel them if they so choose
  end
end

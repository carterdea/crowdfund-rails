class DonationMailer < ApplicationMailer
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::TextHelper
  include DonationsHelper

  def donation_receipt(donation)
    recipient = donation.recipient
    first_name = donation.name.split(' ')[0]

    subject = 'Thank you for your Donation to AdoptTogether'

    merge_vars = {
      'RECIPIENT_TYPE' => recipient.class.name,
      'DONOR_FIRST_NAME' => first_name,
      'DONOR_FULL_NAME' => donation.name,
      'AMOUNT' => pretty_dollars(donation.amount, 2), # Showing 2 decimals so it's more accurate
      'AT_TIP' => pretty_dollars(donation.at_tip, 2),
      'TOTAL' => pretty_dollars(donation.amount + donation.at_tip, 2),
      'RECIPIENT_FULL_NAME' => recipient.full_name,
      'RECIPIENT_LAST_NAME' => recipient.last_name,
      'FAMILY_PROFILE_URL' => family_url(recipient),
      'FAMILY_PROFILE_URL_PARAMETERIZED' => family_url(recipient).to_param,
      'FAMILY_PHOTO_URL' => recipient.photo.large.url,
      'ADOPTION_COUNTRY' => recipient.country_name,
      'TOTAL_RAISED' => pretty_dollars(recipient.donations.pluck(:amount).sum)
    }

    body = mandrill_template('donation-receipt', merge_vars)

    send_mail(donation.email,
              subject,
              body)
  end

  def monthly_donation_receipt(donation)
    recipient = donation.recipient
    first_name = donation.name.split(' ')[0]
    cancel_monthly_donation_url = root_url(trailing_slash: false) + cancel_url(recipient, donation)

    subject = 'Thank you for your Monthly Donation to AdoptTogether'

    merge_vars = {
      'RECIPIENT_TYPE' => recipient.class.name,
      'DONOR_FIRST_NAME' => first_name,
      'DONOR_FULL_NAME' => donation.name,
      'AMOUNT' => pretty_dollars(donation.amount, 2),
      'AT_TIP' => pretty_dollars(donation.at_tip, 2),
      'TOTAL' => pretty_dollars(donation.amount + donation.at_tip, 2),
      'RECIPIENT_FULL_NAME' => recipient.full_name,
      'RECIPIENT_LAST_NAME' => recipient.last_name,
      'FAMILY_PROFILE_URL' => family_url(recipient),
      'FAMILY_PROFILE_URL_PARAMETERIZED' => family_url(recipient).to_param,
      'FAMILY_PHOTO_URL' => recipient.photo.large.url,
      'ADOPTION_COUNTRY' => recipient.country_name,
      'TOTAL_RAISED' => pretty_dollars(recipient.donations.pluck(:amount).sum),
      'CANCEL_MONTHLY_DONATION_URL' => cancel_monthly_donation_url
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
    donor_name = donation.donor_name
    exclamation = %w(Yipee Hooray Yay Yahoo).sample
    subject = "#{exclamation}! #{donor_name} donated to your Adoption on AdoptTogether"

    merge_vars = {
      'EXCLAMATION' => exclamation,
      'DONOR_NAME' => donor_name,
      'RECIPIENT_FIRST_NAME' => recipient.first_name,
      'AMOUNT' => donation.donation_amount,
      'MONTHLY' => donation.recurring,
      'MESSAGE' => simple_format(donation.message),
      'TOTAL_RAISED' => pretty_dollars(recipient.donations.pluck(:amount).sum)
    }

    body = mandrill_template('donation-received', merge_vars)

    send_mail(recipient.user.email,
              subject,
              body)
  end
end

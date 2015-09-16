class DonationMailer < ApplicationMailer
  def donation_receipt(donation)
    @donation = donation
  end

  def monthly_receipt
  end

  def send_monthly(email)
    # sends the user all of their active monthly donations so they can cancel them if they so choose
  end
end

module DonationsHelper
  # TODO make this accept scope: eg: global, family_id, etc.
  def global_donations
    Donation.all.sum(:amount)
  end

  def pretty_dollars(value, decimals= 0)
    decimal_amount = '%0.' + decimals.to_s + 'f'
    dollar_value = sprintf(decimal_amount, value)
    "$" + number_with_delimiter(dollar_value)
  end

  def average_donation_amount
    global_donations / Donation.all.size if Donation.all.size > 0
  end

  def cancel_url(family, donation)
    family_donations_path(family) + '/cancel/' + donation.token
  end
end

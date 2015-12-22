module DonationsHelper
  # TODO make this accept scope: eg: global, family_id, etc.
  def global_donations
    Donation.pluck(:amount).sum
  end

  def pretty_dollars(value, decimals=0)
    decimal_amount = '%0.' + decimals.to_s + 'f'
    dollar_value = sprintf(decimal_amount, value)
    '$' + number_with_delimiter(dollar_value)
  end

  def cancel_url(recipient, donation)
    if donation.recipient_type = 'Family'
      family_donations_path(recipient) + '/cancel/' + donation.token
    else
      charity_donations_path(recipient) + '/cancel/' + donation.token
    end
  end
end

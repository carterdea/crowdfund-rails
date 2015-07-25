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
end

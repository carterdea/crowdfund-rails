module DonationsHelper
  # TODO make this accept scope: eg: global, family_id, etc.
  def global_donations
    Donation.all.sum(:amount)
  end

  def pretty_dollars(value)
    "$" + number_with_delimiter(value.to_i)
  end
end

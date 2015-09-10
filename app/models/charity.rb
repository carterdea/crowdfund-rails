# /app/models/charity.rb
class Charity
  # has_many :donations, as: :recipient

  def full_name
    'AdoptTogether'
  end

  def total_raised
    donations.map(&:amount).inject(:+)
  end
end

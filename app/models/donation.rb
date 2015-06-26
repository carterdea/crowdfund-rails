class Donation < ActiveRecord::Base
  belongs_to :family, dependent: :destroy

  DONATION_AMOUNTS = [
    30, 50, 100, 500, 1000
  ]

  TIP_AMOUNTS = [
    0, 10, 20
  ]

end

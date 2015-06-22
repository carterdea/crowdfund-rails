class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :families

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true
end

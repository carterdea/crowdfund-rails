class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :families

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :email, presence: true, format: VALID_EMAIL_REGEX, uniqueness: { case_sensitive: false }
  validates :password, presence: true

  def has_family?
    self.families.any?
  end
end

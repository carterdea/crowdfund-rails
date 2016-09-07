# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  email                           :string           not null
#  crypted_password                :string
#  salt                            :string
#  created_at                      :datetime
#  updated_at                      :datetime
#  remember_me_token               :string
#  remember_me_token_expires_at    :datetime
#  reset_password_token            :string
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  admin                           :boolean          default(FALSE)
#  last_login_at                   :datetime
#  last_logout_at                  :datetime
#  last_activity_at                :datetime
#  last_login_from_ip_address      :string
#

class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  has_many :authentications, dependent: :destroy
  has_one :family, dependent: :destroy
  has_many :updates, through: :families
  accepts_nested_attributes_for :authentications

  validates :email, presence: true, format: VALID_EMAIL_REGEX, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, allow_nil: true

  authenticates_with_sorcery!
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  def set_family_params_from_fb
    @user_hash.first_name = @family.first_name
    @user_hash.last_name = @family.last_name
  end

  def family?
    family.present?
  end

  def self.to_csv(options = { headers: true })
    CSV.generate(options) do |csv|
      attributes = %w(id email last_login_at last_activity_at last_login_from_ip_address created_at updated_at reset_password_email_sent_at)
      csv << attributes
      all.each do |family|
        csv << attributes.map { |attr| family.send(attr) }
      end
    end
  end
end

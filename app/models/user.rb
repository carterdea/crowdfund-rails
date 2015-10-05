class User < ActiveRecord::Base
  authenticates_with_sorcery!
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, dependent: :destroy
  has_one :family, dependent: :delete
  has_many :updates, through: :families
  accepts_nested_attributes_for :authentications

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :email, presence: true, format: VALID_EMAIL_REGEX, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, allow_nil: true

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

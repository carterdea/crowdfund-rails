class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, :dependent => :destroy
  has_many :families
  accepts_nested_attributes_for :authentications, :families

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :email, presence: true, format: VALID_EMAIL_REGEX, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

  def has_family?
    self.families.any?
  end

  def set_family_params_from_fb
    @user_hash.first_name = @family.first_name
    @user_hash.last_name = @family.last_name
  end

private
  def user_params
    params.permit(:user).require(:email, :password, :authentications_attributes [:user_id, :provider, :uid])
  end
end

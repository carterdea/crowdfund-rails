class Authentication < ApplicationRecord
  belongs_to :user

  def has_linked_facebook?
    authentications.where(provider: 'facebook').present?
  end
end

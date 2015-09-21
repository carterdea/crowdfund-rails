class Update < ActiveRecord::Base
  belongs_to :family, counter_cache: true
  acts_as_sequenced scope: :family_id

  default_scope { order('created_at DESC') }

  mount_uploader :photo, ImageUploader
  validates :title, :message, presence: true

  def date_created
    created_at.strftime('%B %e, %Y')
  end

  # def user_message
  #   message.chomp
  # end  
end

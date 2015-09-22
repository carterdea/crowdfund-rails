require 'file_size_validator'

class Update < ActiveRecord::Base
  belongs_to :family, counter_cache: true
  acts_as_sequenced scope: :family_id

  default_scope { order('created_at DESC') }

  mount_uploader :photo, ImageUploader
  validates :title, :message, presence: true
  validates :photo, file_size: { maximum: 2.megabytes.to_i }

  def date_created
    created_at.strftime('%B %e, %Y')
  end

  def video_embed
    
  end

  # def user_message
  #   message.chomp
  # end
end

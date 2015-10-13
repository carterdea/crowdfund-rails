require 'file_size_validator'

class Update < ActiveRecord::Base
  belongs_to :family, counter_cache: true, touch: true, dependent: :destroy
  acts_as_sequenced scope: :family_id

  before_validation :add_http

  mount_uploader :photo, ImageUploader
  validates :title, :message, presence: true
  validates :photo, file_size: { maximum: 2.megabytes.to_i }

  def date_created
    created_at.strftime('%B %e, %Y')
  end

  private

  def add_http
    if video_url.present?
      self.video_url = "http://#{video_url}" unless video_url[/\Ahttp:\/\//] || video_url[/\Ahttps:\/\//]
    end
  end

  # def user_message
  #   message.chomp
  # end
end

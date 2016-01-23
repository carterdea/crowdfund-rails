require 'file_size_validator'

class Update < ActiveRecord::Base
  belongs_to :family, counter_cache: true, touch: true
  acts_as_sequenced scope: :family_id

  before_validation :add_http

  mount_uploader :photo, ImageUploader
  validates_presence_of :title
  validates_length_of :message, within: 1..10_000
  validates :photo, file_size: { maximum: 2.megabytes.to_i }
  validates :video_url, format: %r{\Ahttp:\/\/(?:.*?)\.?(youtube|vimeo)\.com\/(watch\?[^#]*v=(\w+)|(\d+)).+\z}, allow_blank: true

  def date_created
    created_at.strftime('%B %e, %Y')
  end

  private

  def add_http
    if video_url.present?
      self.video_url = "http://#{video_url}" unless video_url[%r{\Ahttp:\/\/}] || video_url[%r{\Ahttps:\/\/}]
    end
  end
end

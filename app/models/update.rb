# == Schema Information
#
# Table name: updates
#
#  id            :integer          not null, primary key
#  family_id     :integer
#  title         :string
#  message       :text
#  email_donors  :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  sequential_id :integer
#  photo         :string
#  video_url     :string
#

class Update < ActiveRecord::Base
  belongs_to :family, counter_cache: true, touch: true

  validates_presence_of :title
  validates_length_of :message, within: 1..10_000
  validates :photo, file_size: { maximum: 2.megabytes.to_i }
  validates :video_url, format: %r{\Ahttp:\/\/(?:.*?)\.?(youtube|vimeo)\.com\/(watch\?[^#]*v=(\w+)|(\d+)).+\z}, allow_blank: true

  before_validation :add_http

  acts_as_sequenced scope: :family_id
  mount_uploader :photo, ImageUploader
  require 'file_size_validator'

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

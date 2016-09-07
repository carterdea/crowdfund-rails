# == Schema Information
#
# Table name: pages
#
#  id              :integer          not null, primary key
#  title           :string
#  body            :string
#  slug            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  created_by      :string
#  seo_title       :string
#  seo_description :string
#  live            :boolean          default(FALSE)
#

class Page < ActiveRecord::Base
  validates_presence_of [:title, :body, :seo_title, :seo_description]
  validates :slug, uniqueness: true, presence: true, exclusion: { in: EXCLUDED_SLUGS }

  require 'page_body_scrubber'

  def self.tumblr_posts
    Rails.cache.fetch('last_3_tumblr_posts', expires_in: 6.hours) do
      Tumblr::Client.new.posts('adopttogether.tumblr.com', limit: 3)['posts']
    end
  end

  def to_param
    slug
  end
end

require 'page_body_scrubber'

class Page < ActiveRecord::Base
  validates_presence_of [:title, :body, :seo_title, :seo_description]
  validates :slug, uniqueness: true, presence: true, exclusion: { in: EXCLUDED_SLUGS }

  def self.tumblr_posts
    Rails.cache.fetch('last_3_tumblr_posts', expires_in: 6.hours) do
      Tumblr::Client.new.posts('adopttogether.tumblr.com', limit: 3)['posts']
    end
  end

  def to_param
    slug
  end
end

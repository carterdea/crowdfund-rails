class Page < ActiveRecord::Base
  def self.tumblr_posts
    Rails.cache.fetch('last_3_tumblr_posts', expires_in: 1.hour) do
      client = Tumblr::Client.new
      posts_json = client.posts('adopttogether.tumblr.com', limit: 3)['posts']
    end
  end
end

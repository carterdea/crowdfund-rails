class Page < ActiveRecord::Base
  def self.tumblr_posts
    Rails.cache.fetch('last_3_tumblr_posts', expires_in: 12.hours) do
      client = Tumblr::Client.new
      posts_json = client.posts('adopttogether.tumblr.com', limit: 3)['posts']
      posts = posts_json
    end
  end
end

module UpdatesHelper
  def video_embed(video_url)
    OEmbed::Providers.register(OEmbed::Providers::Youtube, OEmbed::Providers::Vimeo)
    resource = OEmbed::Providers.get(video_url) #=> OEmbed::Response
    resource.html.html_safe
  rescue
    "We're having trouble parsing your URL. Can you try again?"
  end
end
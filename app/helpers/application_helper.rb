module ApplicationHelper
	def body_class
		"#{controller_name} #{action_name}"
	end

  def image_thumb(subject, classes)
    image_tag(subject.photo.thumb.url, class: classes)
  end

  def share_count(url)
    SocialShares.total url, %w(facebook twitter googleplus linkedin pinterest)
  rescue
  	0
  end
end

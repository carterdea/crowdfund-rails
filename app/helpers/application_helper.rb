module ApplicationHelper
  def image_thumb(subject, classes)
    image_tag(subject.photo.thumb.url, class: classes)
  end
end

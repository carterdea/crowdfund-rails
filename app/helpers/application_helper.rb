module ApplicationHelper
  def body_class
    "#{controller_name} #{action_name}"
  end

  def title(title = nil)
    if title.present?
      content_for :title, title
    else
      content_for?(:title) ? content_for(:title) + ' | AdoptTogether' : 'AdoptTogether | Helping Families Fund Adoption'
    end
  end

  def meta_description(description = nil)
    if description.present?
      content_for :meta_description, description
    else
      content_for?(:meta_description) ? content_for(:meta_description) : 'AdoptTogether is a non-profit funding platform helping families raise money to pay for adoption costs.'
    end
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

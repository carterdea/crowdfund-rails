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

  def robots_meta_tag
    # Right now we have to hide all pages from Google, but when we launch, just hide the ones that are hidden

    # if @family && @family.visible == false
    #   tag('meta', name: 'robots', content: 'noindex')
    # end
    tag('meta', name: 'robots', content: 'noindex')
  end

  def image_thumb(subject, classes)
    image_tag(subject.photo.thumb.url, class: classes)
  end

  def share_count(url)
    SocialShares.total url, %w(facebook twitter googleplus linkedin pinterest)
  rescue
    0
  end

  def us_states
    [
      ['-- Select a State--', nil],
      ['Alabama', 'AL'],
      ['Alaska', 'AK'],
      ['Arizona', 'AZ'],
      ['Arkansas', 'AR'],
      ['California', 'CA'],
      ['Colorado', 'CO'],
      ['Connecticut', 'CT'],
      ['Delaware', 'DE'],
      ['District of Columbia', 'DC'],
      ['Florida', 'FL'],
      ['Georgia', 'GA'],
      ['Hawaii', 'HI'],
      ['Idaho', 'ID'],
      ['Illinois', 'IL'],
      ['Indiana', 'IN'],
      ['Iowa', 'IA'],
      ['Kansas', 'KS'],
      ['Kentucky', 'KY'],
      ['Louisiana', 'LA'],
      ['Maine', 'ME'],
      ['Maryland', 'MD'],
      ['Massachusetts', 'MA'],
      ['Michigan', 'MI'],
      ['Minnesota', 'MN'],
      ['Mississippi', 'MS'],
      ['Missouri', 'MO'],
      ['Montana', 'MT'],
      ['Nebraska', 'NE'],
      ['Nevada', 'NV'],
      ['New Hampshire', 'NH'],
      ['New Jersey', 'NJ'],
      ['New Mexico', 'NM'],
      ['New York', 'NY'],
      ['North Carolina', 'NC'],
      ['North Dakota', 'ND'],
      ['Ohio', 'OH'],
      ['Oklahoma', 'OK'],
      ['Oregon', 'OR'],
      ['Pennsylvania', 'PA'],
      ['Puerto Rico', 'PR'],
      ['Rhode Island', 'RI'],
      ['South Carolina', 'SC'],
      ['South Dakota', 'SD'],
      ['Tennessee', 'TN'],
      ['Texas', 'TX'],
      ['Utah', 'UT'],
      ['Vermont', 'VT'],
      ['Virginia', 'VA'],
      ['Washington', 'WA'],
      ['West Virginia', 'WV'],
      ['Wisconsin', 'WI'],
      ['Wyoming', 'WY']
    ]
  end
end

module GrantsHelper
  def status_label(grant)
    case grant.status
    when 'requested'
      content_tag :span, 'Requested', class: 'label'
    when 'approved'
      content_tag :span, 'Approved', class: 'label success'
    when 'denied'
      content_tag :span, 'Denied', class: 'label danger'
    end
  end
end

module AdminHelper
  def stripe_url(donation, link_text, title)
    link_to link_text, 'https://dashboard.stripe.com/test/customers/' + donation.stripe_id.to_s, title: title
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == 'desc') ? 'asc' : 'desc'
    link_to title, { sort: column, direction: direction }, class: css_class
  end
end

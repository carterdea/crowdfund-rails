module AdminHelper
  def stripe_url(donation, link_text, title)
    link_to link_text, 'https://dashboard.stripe.com/test/customers/' + donation.stripe_customer_id.to_s, title: title
  end
end
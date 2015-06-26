def user_attributes(overrides = {})
  {
    email: "user@example.com",
    password: "secret"
  }.merge(overrides)
end

def family_attributes(overrides = {})
  {
    first_name: "John",
    last_name: "Doe",
    phone: "(123) 456-7890",
    postal_code: 12345,
    cost: "12345.48",
    country: "United States of America",
    gender: "Male",
    quantity: 1,
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque lacinia purus sed magna dictum, id finibus felis suscipit. Sed eget nibh a ante semper rutrum. Nunc vel dignissim tortor. Donec ut ante tempor, feugiat nisi eu, luctus arcu. Mauris consectetur.",
    status: "Paperwork Filed",
    agency_name: "The Cradle",
    agency_site: "http://www.cradle.org"
  }.merge(overrides)
end

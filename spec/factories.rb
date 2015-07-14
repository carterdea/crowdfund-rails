require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "foo#{n}@example.com"}
    password "secret"
  end

  factory :family do
    first_name  "John"
    last_name   "Doe"
    phone       "(123) 456-7890"
    postal_code 12345
    cost        "12345.48"
    country     "United States of America"
    gender      "Male"
    quantity    1
    description "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque lacinia purus sed magna dictum, id finibus felis suscipit. Sed eget nibh a ante semper rutrum. Nunc vel dignissim tortor. Donec ut ante tempor, feugiat nisi eu, luctus arcu. Mauris consectetur."
    status      "Paperwork Filed"
    agency_name "The Cradle"
    agency_site "http://www.cradle.org"
    approved    true
  end
end
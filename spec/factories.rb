require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "foo#{n}@example.com" }
    password 'secret'
  end

  factory :family do
    user
    first_name 'John'
    last_name 'Doe'
    postal_code '12345'
    cost 12_345
    country 'US'
    gender 'Male'
    quantity 1
    description 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque lacinia purus sed magna dictum, id finibus felis suscipit. Sed eget nibh a ante semper rutrum. Nunc vel dignissim tortor. Donec ut ante tempor, feugiat nisi eu, luctus arcu. Mauris consectetur.'
    photo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'test_family.jpg')) }
    status 'Paperwork Filed'
    agency_name 'The Cradle'
    agency_site 'http://www.cradle.org'
    approved true
  end

  # factory :donation do
  #   family
  # end
end

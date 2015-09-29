require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "foo#{n}@example.com" }
    password 'secret'
  end

  factory :charity do
    name 'AdoptTogether'
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
    donations_count 0
    updates_count 0
    grants_count 0
    trait :approval_letter_file do
      approval_letter_file 'file.jpg'
    end
  end

  factory :donation do
    association :recipient, factory: :family
    amount '1234'
    recurring 'false'
    at_tip '5'
    family_email_updates true
    message 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
    name 'Jack Smith'
    sequence(:email) { |n| "bar#{n}@example.com" }
    hide_amount false
    anonymous false
  end
end

namespace :db do
  desc 'Erase & fill database with sample data'
  task populate: :environment do
    require 'populator'
    require 'ffaker'

    [Update, Donation, Family, User].each do |klass|
      klass.destroy_all
      ActiveRecord::Base.connection.reset_pk_sequence!(klass.table_name)
    end

    User.populate 1 do |user|
      user.email = 'hankfortener@gmail.com'
      user.admin = true
    end

    User.populate 50 do |user|
      user.email = FFaker::Internet.email
      Family.populate 1 do |family|
        family.user_id = user.id
        family.first_name = FFaker::Name.first_name
        family.last_name = FFaker::Name.last_name
        family.phone = FFaker::PhoneNumber.phone_number
        family.postal_code = FFaker::AddressUS.zip_code
        family.cost = FFaker::Address.building_number
        family.gender = FFaker::Gender.maybe
        family.country = FFaker::AddressUS.country_code
        family.quantity = [1..5].sample
        family.description = FFaker::BaconIpsum.paragraphs(2)
        family.status = 'Awaiting Matching'
        family.agency_name = FFaker::Company.name
        family.agency_site = FFaker::Internet.http_url
        family.approved = true
        family.slug = 'the-' + family.last_name.parameterize
        Donation.populate 0..35 do |donation|
          donation.recipient_type = 'Family'
          donation.recipient_id = family.id
          donation.amount = [30, 50, 100, 500, 1000, 400, 25, 5, 1, 18]
          donation.at_tip = [0, 10, 20]
          donation.name = FFaker::Name.name
          donation.hide_amount = FFaker::Boolean.maybe
          donation.anonymous = FFaker::Boolean.maybe
          donation.message = FFaker::BaconIpsum.phrases(2).sample
          donation.email = FFaker::Internet.email
          donation.at_newsletter = FFaker::Boolean.maybe
          donation.recurring = FFaker::Boolean.maybe
        end
        Update.populate 0..15 do |update|
          update.family_id = family.id
          update.title = FFaker::BaconIpsum.phrases(2).sample
          update.message = FFaker::BaconIpsum.paragraphs(5).sample
          update.on_profile = FFaker::Boolean.maybe
        end
      end
    end
    puts 'Your db is all seeded! 👌'
  end
end

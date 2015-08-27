# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

namespace :db do
  desc "Erase & fill database with sample data"
  task populate: :environment do
    require 'populator'
    require 'ffaker'
    require 'sorcery'

    [Donation, Family, User].each do |klass|
      klass.delete_all
      ActiveRecord::Base.connection.reset_pk_sequence!(klass.table_name)
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
        family.description = FFaker::Lorem.paragraphs
        family.status = "Awaiting Matching"
        family.agency_name = FFaker::Company.name
        family.agency_site = FFaker::Internet.http_url
        Donation.populate 0..35 do |donation|
          donation.family_id = family.id
          donation.amount = [30,50,100,500,1000,400,25,5,1,18]
          donation.at_tip = [0,10,20]
          donation.name = FFaker::Name.name
          donation.hide_amount = FFaker::Boolean.maybe
          donation.anonymous = FFaker::Boolean.maybe
          donation.message = FFaker::BaconIpsum.sentences
          donation.email = FFaker::Internet.email
          donation.at_newsletter = FFaker::Boolean.maybe
          donation.recurring = FFaker::Boolean.maybe
        end
      end
    end
  end
  puts 'All seeded! 👌'
end

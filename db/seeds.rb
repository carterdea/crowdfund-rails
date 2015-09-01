namespace :db do
  desc 'Fill database with sample data'
  task populate: :environment do
    require 'populator'

    User.populate 1 do |user|
      user.email = 'hankfortener@gmail.com'
      Family.populate 1 do |family|
        family.user_id = 1
        family.first_name = 'Adopt'
        family.last_name = 'Together'
        family.postal_code = '90068'
        family.cost = 999_999
        family.gender = 'male'
        family.quantity = 1
        family.description = 'AdoptTogether is bringing kids home!'
        family.status = 'Completed'
        family.agency_name = 'AdoptTogether'
        family.agency_site = 'www.adopttogether.org'
        family.approved = true
      end
    end
  end
end

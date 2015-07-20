99.times do |n|
  email = FFaker::Internet.email
  password  = "secret"
  User.create!(email: email,
               password: password)
  first_name = FFaker::Name.first_name
  last_name = FFaker::Name.last_name
  phone = FFaker::PhoneNumber.short_phone_number
  postal_code = FFaker::AddressUS.zip_code
  cost = FFaker::Address.building_number
  gender = FFaker::Gender.maybe
  country = FFaker::Address.country_code
  quantity = rand(1..5)
  description = FFaker::Lorem.paragraphs
  status = "Awaiting Matching"
  adoption_agency = FFaker::Company.name
  agency_site = FFaker::Internet.http_url
  Family.create!(user_id: n,
                first_name: first_name,
                last_name: last_name,
                phone: phone,
                postal_code: postal_code,
                cost: cost,
                gender: gender,
                country: country,
                quantity: quantity,
                description: description,
                photo: FFaker::Avatar.image,
                status: status,
                adoption_agency: adoption_agency,
                agency_site: agency_site)
end
# namespace :db do
#   desc "Fill database with sample data"
#   task populate: :environment do
    
#       AMOUNTS = [30,50,100,500,1000,400,25,5,1,18]
#       AT_TIPS = [0,10,20]
#       amount = AMOUNTS.sample
#       at_tip = AT_TIPS.sample
#       name = FFaker::name
#       hide_amount = FFaker::Boolean.maybe
#       anonymous = FFaker::Boolean.maybe
#       message = FFaker::BaconIpsum.sentences
#       email = FFaker::Internet.email
#       at_newsletter = FFaker.Boolean.maybe
#       recurring = FFaker.Boolean.maybe
#       Donation.create!(family_id: n+1,
#                       amount: amount,
#                       at_tip: at_tip,
#                       name: name,
#                       hide_amount: hide_amount,
#                       anonymous: anonymous,
#                       message: message,
#                       email: email,
#                       at_newsletter: at_newsletter,
#                       recurring: recurring)

#     end
#   end
# end

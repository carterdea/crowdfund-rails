
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
puts 'All seeded! 👌'

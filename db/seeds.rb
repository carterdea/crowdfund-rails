namespace :db do
  Charity.create(name: 'AdoptTogether')
  User.create(email: 'hankfortener@gmail.com', admin: true)
end

Factory.define :user do |f|
  f.sequence(:email) { |n| "foo#{n}@example.com" }
  f.password "secret"
end

Factory.define :family do |f|
  
end
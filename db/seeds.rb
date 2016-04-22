# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'


10.times do
    User.create!(
      username: Faker::Name.name,
      email: Faker::Internet.email,
      password: Faker::Internet.password
    )
end
users = User.all

50.times do
  Wiki.create!(
    title: Faker::Lorem.word,
    body: Faker::Lorem.sentence,
    user: users.sample
  )
end

wiki = Wiki.all

puts "Seeding done!"
puts "#{User.count} users now exist"
puts "#{Wiki.count} wikis now exist"

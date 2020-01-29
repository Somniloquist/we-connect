# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

99.times do |i|
  User.create!(firstname: Faker::Name.first_name,
              lastname: Faker::Name.last_name,
              email: "test#{i+1}@example.com",
              password: "password",
              gender: Faker::Gender.binary_type,
              about: Faker::Quote.famous_last_words)
end

User.create!(firstname: "Robin",
            lastname: "Unger",
            email: "robin.e.unger@gmail.com",
            password: "password",
            birthday: Time.now,
            about: "Developer")

User.update_all confirmed_at: DateTime.now

users = User.order(:created_at).take(10)
50.times do
  users.each { |user| user.posts.create!(body: Faker::Hipster.paragraph) }
end

users = User.all
user = users.last

users[0...10].each { |friend| user.add_friend(friend) }

users[0...10].each do |user|
  file = open("https://robohash.org/#{user.lastname}")
  user.avatar.attach(
    io: file,
    filename: "avatar.png",
    content_type: file.content_type
  )
end

Friendship.all.each { |friendship| friendship.accept }

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(firstname: "Test",
            lastname: "User",
            email: "test@example.com",
            password: "password",
            birthday: Time.now)

99.times do |i|
  User.create!(firstname: Faker::Name.first_name,
              lastname: Faker::Name.last_name,
              email: "example#{i}@example.com",
              password: "password",
              gender: Faker::Gender.binary_type)
end

User.create!(firstname: "Robin",
            lastname: "Unger",
            email: "robin.e.unger@gmail.com",
            password: "password",
            birthday: Time.now)




users = User.order(:created_at).take(10)
50.times do
  content = Faker::Lorem.paragraph
  users.each { |user| user.posts.create!(body: content) }
end

users = User.all
user = users.last

users[1..10].each { |friend| user.add_friend(friend) }
Friendship.all.each { |friendship| friendship.accept }

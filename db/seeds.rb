# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

  User.create!(firstname: "Robin",
              lastname: "Unger",
              email: "robin.e.unger@gmail.com",
              password: "password",
              birthday: Time.now,
              gender: "male")

10.times do |i|
  User.create!(firstname: "Test",
              lastname: "User-#{i}",
              email: "testuser#{i}@example.com",
              password: "password",
              birthday: Time.now,
              gender: "male")
end

User.all.each do |user|
  5.times do |i|
    user.posts.build(body: Faker::Lorem.paragraph).save
  end
  user.posts.build(body: Faker::Lorem.paragraph(sentence_count: 50)).save
end

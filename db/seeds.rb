# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

99.times do |i|
  User.create(firstname: Faker::Name.first_name,
              lastname: Faker::Name.last_name,
              email: "test#{i+1}@example.com",
              password: Devise.friendly_token[0, 20],
              gender: Faker::Gender.binary_type,
              about: Faker::Quote.famous_last_words)
end

User.create(firstname: "Robin",
            lastname: "Unger",
            email: "robin.e.unger@gmail.com",
            password: Devise.friendly_token[0, 20],
            birthday: Time.now,
            about: "Developer")

# create a test user so people viewing the site can skip the sign up process
User.create!(firstname: "Test",
            lastname: "User",
            email: "testuser@example.com",
            password: "password",
            birthday: Time.now)

User.update_all confirmed_at: DateTime.now

users = User.order(:created_at).take(10)
50.times do
  users.each { |user| user.posts.create!(body: Faker::Hipster.paragraph) }
end

users = User.all
user = users.last

users[0...5].each { |friend| user.add_friend(friend) }
Friendship.all.each { |friendship| friendship.accept }
users[6...11].each { |friend| friend.add_friend(user) }

# upload some banners and avatars
# placeholder avatars from https://pravatar.cc/
# banner images from https://picsum.photos/
users[0...10].each_with_index do |user, index|
  file = open("https://i.pravatar.cc/150?img=#{index}")
  user.avatar.attach(
    io: file,
    filename: "avatar.png",
    content_type: file.content_type
  )
  file = open("https://picsum.photos/seed/#{index}/1200/600")
  user.banner_picture.attach(
    io: file,
    filename: "banner.png",
    content_type: file.content_type
  )
end


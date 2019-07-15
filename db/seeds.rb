User.create!(name: "TuanAnh",
    email: "tuananh@gmail.com",
    password: "tuananh",
    password_confirmation: "tuananh",
    admin: true,
    activated: true,
    activated_at: Time.zone.now)

69.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name, email: email,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now)
end

users = User.order(:created_at).take(10)
30.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }

end

User.create!(name: "TuanAnh",
    email: "tuananh@gmail.com",
    password: "tuananh",
    password_confirmation: "tuananh",
    admin: true,
    activated: true,
    activated_at: Time.zone.now)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name, email: email,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now)
end

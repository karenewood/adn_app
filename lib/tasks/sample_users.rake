namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Karen Wood",
                 email: "Northernyoga@gmail.com",
                 password: "Sp1derg1rl",
                 password_confirmation: "Sp1derg1rl")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@solutionadn.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    EquipeType.create!(name: "Soccer")
    EquipeType.create!(name: "Football")
    EquipeType.create!(name: "Natation")
    EquipeType.create!(name: "Baseball")
    EquipeType.create!(name: "Basketball")
    EquipeType.create!(name: "Tennis")
    EquipeType.create!(name: "Volleyball")
  end
end
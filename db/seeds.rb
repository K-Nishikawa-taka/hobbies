# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "朝霜",
             personal_id: "A",
             email: "Yugumo16@Kancolle.jp",
             password:  "Yugumo16",
             password_confirmation: "Yugumo16",
             admin: true)

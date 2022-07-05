# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
require 'faker'
Faker::Config.locale = 'en'
20.times do |_id|
  Client.create!(
    name: Faker::Name.first_name,
    surname: Faker::Name.last_name
  )
end
10.times do |_id|
  Assignee.create!(
    name: Faker::Name.first_name,
    surname: Faker::Name.last_name
  )
end

%w[wash repair diagnostics consultation].each do |item|
  Category.create!(
    title: item
  )
end

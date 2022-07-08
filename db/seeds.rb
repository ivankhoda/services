# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
require 'faker'
Faker::Config.locale = 'en'
# 20.times do |_id|
#   Client.create!(
#     name: Faker::Name.first_name,
#     surname: Faker::Name.last_name
#   )
# end
# 10.times do |_id|
#   Assignee.create!(
#     name: Faker::Name.first_name,
#     surname: Faker::Name.last_name
#   )
# end

# %w[wash repair diagnostics consultation].each do |item|
#   Category.create!(
#     title: item
#   )
# end

# 20.times do |_id|
#   client = Client.all.sample
#   service = Service.all.sample
#   service2 = Service.all.sample
#   assignee = Assignee.all.sample
#   price = rand(1000)
#   Order.create!(
#     client_name: client.name + " #{client.surname}",
#     # positions: [service.title, service2.title],
#     assignee_name: assignee.name + " #{assignee.surname}",
#     price:,
#     client_id: client.id,
#     assignee_id: assignee.id
#   )
# end

10.times do |_id|
  category = Category.all.sample
  GenericService.create!(
    title: Faker::Commerce.product_name,
    category_title: category.title,
    category_id: category.id
  )
end

# create_table "orders", force: :cascade do |t|
#   t.text "client"
#   t.text "services"
#   t.text "assignee"
#   t.integer "price"
#   t.bigint "client_id", null: false
#   t.bigint "assignee_id", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["assignee_id"], name: "index_orders_on_assignee_id"
#   t.index ["client_id"], name: "index_orders_on_client_id"
# end

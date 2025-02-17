# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require 'faker'
require 'open-uri'
require 'fileutils'


puts "Cleaning up storage..."
FileUtils.rm_rf(Rails.root.join('storage'))
FileUtils.mkdir_p(Rails.root.join('storage'))


ActiveStorage::Blob.all.each do |blob|
  blob.purge
end
ActiveStorage::Attachment.destroy_all

puts "Cleaning up database records..."
User.destroy_all
Course.destroy_all

puts "Creating admin user..."
root = User.create(
  email_address: "admin@erudite.com",
  first_name: "Christopher",
  last_name: "Fagg",
  password: "password",
  password_confirmation: "password")

puts "Creating staff user..."
staff = User.create(
  email_address: "staff@erudite.com",
  first_name: "Joe",
  last_name: "Bloggs",
  password: "password",
  password_confirmation: "password",
  )

puts "Creating student users and courses..."
10.times do |i|
  user = User.create(
    email_address: "student#{i+1}@erudite.com",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: "password",
    password_confirmation: "password",
    )

  lang = Faker::ProgrammingLanguage.name
  course = Course.new(
    title: lang,
    owner: "admin@erudite.com"
  )

  img = URI.open("https://loremflickr.com/500/500")
  course.files.attach(io: img, filename: "test.jpg", content_type: "image/jpg")

  course.save
  puts "Created course: #{course.title}"
end

puts "Seed completed successfully!"

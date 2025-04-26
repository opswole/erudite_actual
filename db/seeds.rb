# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require 'faker'
require 'open-uri'

require_relative 'seed_courses/computer_science'
require_relative 'seed_courses/environmental'
require_relative 'seed_courses/biomedical'
require_relative 'seed_notebook/notebook'

puts "Cleaning up storage..."

puts "Cleaning up database records..."
User.destroy_all
Course.destroy_all
Unit.destroy_all
Topic.destroy_all

# TODO: Profile Pictures on seed
puts "Creating admin..."
admin = User.create!(
  email_address: "admin@erudite.com",
  account_type: 2,
  first_name: "Christopher",
  last_name: "Fagg",
  password: "password",
  password_confirmation: "password"
)

staff = User.create!(
  email_address: "staff@erudite.com",
  account_type: 1,
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  password: "password",
  password_confirmation: "password"
)

puts "Creating staff..."
5.times.with_index do |i|
  User.create!(
  email_address: "staff#{i + 1}@erudite.com",
  account_type: 1,
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  password: "password",
  password_confirmation: "password"
)
end

puts "Creating default course..."
cs = Course.create!(
  title: "BSc Computer Science",
  owners: [ admin ]
)

env = Course.create!(
  title: "BSc Environmental Science",
  owners: [ admin ]
)

bio = Course.create!(
  title: "BSc Biomedical Science",
  owners: [ admin ]
)

puts "Creating student users..."
students = []
students = 15.times.map do |i|
  user = User.create!(
    email_address: "student#{i+1}@erudite.com",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: "password",
    password_confirmation: "password"
  )

  user
end

puts "Creating units..."

pdfs = [ "artificial_intelligence.pdf",
        "computer_networks.pdf",
        "database_systems.pdf",
        "human_computer_interaction.pdf",
        "software_engineering.pdf",
        "cloud_computing.pdf",
        "cybersecurity.pdf",
        "data_structures_and_algorithms.pdf",
        "operating_systems.pdf",
        "web_development.pdf" ]


puts "Creating CompSci"
COMPUTER_SCIENCE.each_with_index do |unit_data, i|
  unit = Unit.create!(
    title: unit_data[:title],
    description: unit_data[:description],
    course: cs
  )

  pdf_path = Rails.root.join('db/seed_pdfs', pdfs[i])

  unit_data[:topics].each do |topic_data|
    topic = Topic.create!(
      title: topic_data[:title],
      description: topic_data[:description],
      unit: unit
    )

    begin
      if File.exist?(pdf_path)
        topic.files.attach(
          io: File.open(pdf_path),
          filename: pdf_path.to_s,
          content_type: "application/pdf"
        )
        puts "PDF attached for unit: #{unit.title}"
      else
        puts "Missing PDF for unit: #{unit.title} at #{pdf_path}"
      end
    rescue => e
      puts "Failed to attach PDF to topic #{topic.title}: #{e.message}"
    end
  end
end

puts "Creating Environmental Sci"
ENVIRONMENTAL.each_with_index do |unit_data, i|
  unit = Unit.create!(
    title: unit_data[:title],
    description: unit_data[:description],
    course: env
  )

  pdf_path = Rails.root.join('db/seed_pdfs', pdfs[i])

  unit_data[:topics].each do |topic_data|
    topic = Topic.create!(
      title: topic_data[:title],
      description: topic_data[:description],
      unit: unit
    )

    begin
      if File.exist?(pdf_path)
        topic.files.attach(
          io: File.open(pdf_path),
          filename: pdf_path.to_s,
          content_type: "application/pdf"
        )
        puts "PDF attached for unit: #{unit.title}"
      else
        puts "Missing PDF for unit: #{unit.title} at #{pdf_path}"
      end
    rescue => e
      puts "Failed to attach PDF to topic #{topic.title}: #{e.message}"
    end
  end
end

puts "Creating Biomedical"
BIOMEDICAL.each_with_index do |unit_data, i|
  unit = Unit.create!(
    title: unit_data[:title],
    description: unit_data[:description],
    course: bio
  )

  pdf_path = Rails.root.join('db/seed_pdfs', pdfs[i])

  unit_data[:topics].each do |topic_data|
    topic = Topic.create!(
      title: topic_data[:title],
      description: topic_data[:description],
      unit: unit
    )

    begin
      if File.exist?(pdf_path)
        topic.files.attach(
          io: File.open(pdf_path),
          filename: pdf_path.to_s,
          content_type: "application/pdf"
        )
        puts "PDF attached for unit: #{unit.title}"
      else
        puts "Missing PDF for unit: #{unit.title} at #{pdf_path}"
      end
    rescue => e
      puts "Failed to attach PDF to topic #{topic.title}: #{e.message}"
    end
  end
end

puts "Creating enrollments..."
Enrollment.find_or_create_by!(user: admin, course: cs)
Enrollment.find_or_create_by!(user: staff, course: cs)

courses = [
  Course.find_or_create_by!(title: "BSc Computer Science"),
  Course.find_or_create_by!(title: "BSc Biomedical Science"),
  Course.find_or_create_by!(title: "BSc Environmental Science")
]

students.each_with_index do |student, index|
  course = courses[index / 5]
  Enrollment.find_or_create_by!(user: student, course: Course.find_by(title: course.title))
end

cs_units = cs.units.limit(3)
env_units = env.units.limit(3)
bio_units = bio.units.limit(3)

puts "Creating Assignments"
cs_units.each_with_index do |u, i|
  u.create_assignment(
    title: "#{u.title} Assignment",
    description: "Assignment #{i} for #{u.title}",
    deadline: DateTime.now + rand(1..30).days
  )
end

env_units.each_with_index do |u, i|
  u.create_assignment(
    title: "#{u.title} Assignment",
    description: "Assignment #{i} for #{u.title}",
    deadline: DateTime.now + rand(1..30).days
    )
end

bio_units.each_with_index do |u, i|
  u.create_assignment(
    title: "#{u.title} Assignment",
    description: "Assignment #{i} for #{u.title}",
    deadline: DateTime.now + rand(1..30).days
    )
end

@cs_taggable = User
                    .joins(:enrollment)
                    .where(enrollments: { course_id: Course.find_or_create_by!(title: "BSc Computer Science").id })
@bio_taggable = User
                 .joins(:enrollment)
                 .where(enrollments: { course_id: Course.find_or_create_by!(title: "BSc Biomedical Science").id })

@env_taggable = User
                 .joins(:enrollment)
                 .where(enrollments: { course_id: Course.find_or_create_by!(title: "BSc Environmental Science").id })

puts "Creating Messages"
cs.topics.each do |topic|
  10.times do
    topic.messages.create(
      user_id: @cs_taggable.sample.id,
      content: Faker::Quote.famous_last_words
    )
  end
end

bio.topics.each do |topic|
  10.times do
    topic.messages.create(
      user_id: @bio_taggable.sample.id,
      content: Faker::Quote.famous_last_words
    )
  end
end

env.topics.each do |topic|
  10.times do
    topic.messages.create(
      user_id: @env_taggable.sample.id,
      content: Faker::Quote.famous_last_words
    )
  end
end

puts "creating mentions"
cs.topics.each do |topic|
  topic.messages.sample(3).each do |message|
    message.mentions.create(
      user_id:  @cs_taggable.sample.id,
    )
  end
end

bio.topics.each do |topic|
  topic.messages.sample(3).each do |message|
    message.mentions.create(
      user_id:  @bio_taggable.sample.id,
      )
  end
end

env.topics.each do |topic|
  topic.messages.sample(3).each do |message|
    message.mentions.create(
    user_id:  @env_taggable.sample.id,
    )
  end
end

puts "creating notebooks"
Notebook.all.each do |notebook|
  notebook.content.body = NOTEBOOK
  notebook.save
end

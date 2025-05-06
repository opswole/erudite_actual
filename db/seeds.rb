require 'faker'
require 'open-uri'

require_relative 'seed_courses/computer_science'
require_relative 'seed_courses/environmental'
require_relative 'seed_courses/biomedical'
require_relative 'seed_notebook/notebook'

puts "Cleaning up storage..."
ActiveStorage::Blob.all.each(&:purge)

puts "Creating shared PDF blob..."
pdf_path = Pathname.new("db/seed_pdfs/prod.pdf")
shared_pdf_blob = if File.exist?(pdf_path)
                    ActiveStorage::Blob.create_and_upload!(
                      io: File.open(pdf_path),
                      filename: 'prod.pdf',
                      content_type: 'application/pdf'
                    )
                  else
                    puts "Warning: shared.pdf not found at #{pdf_path}. Skipping PDF attachment."
                    nil
                  end

puts "Cleaning up database records..."
User.destroy_all
Course.destroy_all
Unit.destroy_all
Topic.destroy_all

puts "Creating admin..."
admin = User.create!(
  email_address: "admin@erudite.com",
  account_type: 2,
  first_name: "Christopher",
  last_name: "Fagg",
  password: "password",
  password_confirmation: "password"
)

puts "Creating staff..."
staff = User.create!(
  email_address: "staff@erudite.com",
  account_type: 1,
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  password: "password",
  password_confirmation: "password"
)

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

puts "Creating default courses..."
cs = Course.create!(
  title: "BSc Computer Science",
  owners: [ admin, staff ]
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
students = 15.times.map do |i|
  User.create!(
    email_address: "student#{i + 1}@erudite.com",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: "password",
    password_confirmation: "password"
  )
end

puts "Creating units and topics..."

puts "Creating CompSci..."
COMPUTER_SCIENCE.each do |unit_data|
  unit = Unit.create!(
    title: unit_data[:title],
    description: unit_data[:description],
    course: cs
  )

  unit_data[:topics].each do |topic_data|
    topic = Topic.create!(
      title: topic_data[:title],
      description: topic_data[:description],
      unit: unit
    )

    if shared_pdf_blob
      begin
        topic.files.attach(shared_pdf_blob)
        puts "Shared PDF attached to topic: #{topic.title}"
      rescue => e
        puts "Failed to attach shared PDF to topic #{topic.title}: #{e.message}"
      end
    end
  end
end

puts "Creating Environmental Sci..."
ENVIRONMENTAL.each do |unit_data|
  unit = Unit.create!(
    title: unit_data[:title],
    description: unit_data[:description],
    course: env
  )

  unit_data[:topics].each do |topic_data|
    topic = Topic.create!(
      title: topic_data[:title],
      description: topic_data[:description],
      unit: unit
    )

    if shared_pdf_blob
      begin
        topic.files.attach(shared_pdf_blob)
        puts "Shared PDF attached to topic: #{topic.title}"
      rescue => e
        puts "Failed to attach shared PDF to topic #{topic.title}: #{e.message}"
      end
    end
  end
end

puts "Creating Biomedical..."
BIOMEDICAL.each do |unit_data|
  unit = Unit.create!(
    title: unit_data[:title],
    description: unit_data[:description],
    course: bio
  )

  unit_data[:topics].each do |topic_data|
    topic = Topic.create!(
      title: topic_data[:title],
      description: topic_data[:description],
      unit: unit
    )

    if shared_pdf_blob
      begin
        topic.files.attach(shared_pdf_blob)
        puts "Shared PDF attached to topic: #{topic.title}"
      rescue => e
        puts "Failed to attach shared PDF to topic #{topic.title}: #{e.message}"
      end
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

puts "Creating assignments..."
cs_units = cs.units.limit(3)
env_units = env.units.limit(3)
bio_units = bio.units.limit(3)

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

puts "Creating taggable users..."
@cs_taggable = User.joins(:enrollment).where(enrollments: { course_id: Course.find_or_create_by!(title: "BSc Computer Science").id })
@bio_taggable = User.joins(:enrollment).where(enrollments: { course_id: Course.find_or_create_by!(title: "BSc Biomedical Science").id })
@env_taggable = User.joins(:enrollment).where(enrollments: { course_id: Course.find_or_create_by!(title: "BSc Environmental Science").id })

puts "Creating messages..."
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

puts "Creating mentions..."
cs.topics.each do |topic|
  topic.messages.sample(3).each do |message|
    message.mentions.create(
      user_id: @cs_taggable.sample.id
    )
  end
end

bio.topics.each do |topic|
  topic.messages.sample(3).each do |message|
    message.mentions.create(
      user_id: @bio_taggable.sample.id
    )
  end
end

env.topics.each do |topic|
  topic.messages.sample(3).each do |message|
    message.mentions.create(
      user_id: @env_taggable.sample.id
    )
  end
end

puts "Creating notebooks..."
Notebook.all.each do |notebook|
  notebook.content.body = NOTEBOOK
  notebook.save
end

puts "Seeding complete!"

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require 'faker'
require 'open-uri'
require 'fileutils'

puts "Cleaning up storage..."

puts "Cleaning up database records..."
User.destroy_all
Course.destroy_all
Unit.destroy_all

puts "Creating admin"
admin = User.create!(
  email_address: "admin@erudite.com",
  account_type: 2,
  first_name: "Christopher",
  last_name: "Fagg",
  password: "password",
  password_confirmation: "password"
)

puts "Creating staff"
staff = User.create!(
  email_address: "staff@erudite.com",
  account_type: 1,
  first_name: "Joe",
  last_name: "Bloggs",
  password: "password",
  password_confirmation: "password"
)

puts "Creating default courses..."
course = Course.create!(
  title: "BSc Computer Science",
  owner: admin
)

puts "Creating student users..."
10.times do |i|
  User.create!(
    email_address: "student#{i+1}@erudite.com",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: "password",
    password_confirmation: "password"
  )
end

puts "Creating units..."
units = [
  {
    title: "Software Engineering",
    description: "Learn principles and practices for developing high-quality software.",
    topics: [
      { title: "Agile Methodologies", description: "Explore iterative software development approaches like Scrum and Kanban." },
      { title: "Software Design Patterns", description: "Understand reusable solutions to common software design problems." }
    ]
  },
  {
    title: "Data Structures and Algorithms",
    description: "Master efficient data organization and algorithmic problem-solving techniques.",
    topics: [
      { title: "Sorting Algorithms", description: "Learn popular sorting algorithms like QuickSort and MergeSort." },
      { title: "Trees and Graphs", description: "Study tree and graph data structures and their applications." }
    ]
  },
  {
    title: "Database Systems",
    description: "Understand database design, management, and data retrieval techniques.",
    topics: [
      { title: "Relational Database Design", description: "Learn how to design normalized relational databases." },
      { title: "NoSQL Databases", description: "Explore non-relational database models and their use cases." }
    ]
  },
  {
    title: "Operating Systems",
    description: "Learn the fundamentals of operating system design and implementation.",
    topics: [
      { title: "Memory Management", description: "Understand techniques for memory allocation and virtual memory." },
      { title: "File Systems", description: "Explore how operating systems manage and store files." }
    ]
  },
  {
    title: "Artificial Intelligence",
    description: "Delve into AI concepts and techniques for intelligent decision-making.",
    topics: [
      { title: "Machine Learning", description: "Study supervised and unsupervised learning algorithms." },
      { title: "Natural Language Processing", description: "Explore techniques for language understanding and generation." }
    ]
  },
  {
    title: "Computer Networks",
    description: "Learn the principles of network communication and security.",
    topics: [
      { title: "Network Protocols", description: "Study protocols like TCP/IP and HTTP for network communication." },
      { title: "Network Security", description: "Understand techniques for securing networked systems." }
    ]
  },
  {
    title: "Web Development",
    description: "Develop skills for building modern, responsive web applications.",
    topics: [
      { title: "Front-End Frameworks", description: "Learn about popular frameworks like React and Angular." },
      { title: "Web Performance Optimization", description: "Explore techniques to improve website loading and interactivity." }
    ]
  },
  {
    title: "Cybersecurity",
    description: "Gain knowledge of strategies to protect systems and data from threats.",
    topics: [
      { title: "Ethical Hacking", description: "Learn penetration testing methods to identify vulnerabilities." },
      { title: "Encryption Techniques", description: "Explore algorithms for encrypting and securing data." }
    ]
  },
  {
    title: "Human-Computer Interaction",
    description: "Understand how users interact with technology to design better interfaces.",
    topics: [
      { title: "Usability Testing", description: "Learn methods for evaluating users experience." },
      { title: "UI/UX Design Principles", description: "Explore design principles for creating users-friendly interfaces." }
    ]
  },
  {
    title: "Cloud Computing",
    description: "Study cloud architecture, services, and deployment models.",
    topics: [
      { title: "Cloud Service Models", description: "Understand IaaS, PaaS, and SaaS cloud service models." },
      { title: "Containerization", description: "Learn about container technologies like Docker and Kubernetes." }
    ]
  }
]

units.each do |unit_data|
  unit = Unit.create!(
    title: unit_data[:title],
    description: unit_data[:description],
    course_id: course.id
  )

  unit_data[:topics].each do |topic_data|
    topic = Topic.new(
      title: topic_data[:title],
      description: topic_data[:description],
      unit: unit
    )

    image_url = Faker::LoremFlickr.image(size: "200x200", search_terms: [ 'cat' ])
    file = URI.open(image_url)

    topic.files.attach(
      io: file,
      filename: "test.jpg",
      content_type: "image/jpeg",
      key: "#{Rails.env}/blog_content/intuitive_filename-#{SecureRandom.uuid}.jpg"
    )

    topic.save
  end

  puts "Created unit: #{unit.title}"
end

puts "Seed completed successfully!"

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require 'faker'
require 'open-uri'

puts "Cleaning up storage..."

puts "Cleaning up database records..."
User.destroy_all
Course.destroy_all
Unit.destroy_all
Topic.destroy_all
Enrollment.destroy_all

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
  first_name: "Joe",
  last_name: "Bloggs",
  password: "password",
  password_confirmation: "password"
)

puts "Creating default course..."
course = Course.create!(
  title: "BSc Computer Science",
  owner: "Department of Computer Science"
)

puts "Creating student users..."
students = []
10.times do |i|
  students << User.create!(
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
      { title: "Software Design Patterns", description: "Understand reusable solutions to common software design problems." },
      { title: "Version Control Systems", description: "Learn about tools like Git for managing code changes." },
      { title: "Continuous Integration/Continuous Deployment", description: "Understand CI/CD pipelines for automated software delivery." },
      { title: "Software Testing", description: "Explore unit testing, integration testing, and test-driven development." },
      { title: "Requirements Engineering", description: "Learn techniques for gathering and analyzing software requirements." },
      { title: "Software Maintenance", description: "Understand strategies for maintaining and updating software systems." },
      { title: "DevOps Practices", description: "Study the integration of development and operations for efficient workflows." },
      { title: "Microservices Architecture", description: "Explore designing applications as a collection of loosely coupled services." },
      { title: "Code Refactoring", description: "Learn techniques for improving code structure without changing its behavior." }
    ]
  },
  {
    title: "Data Structures and Algorithms",
    description: "Master efficient data organization and algorithmic problem-solving techniques.",
    topics: [
      { title: "Sorting Algorithms", description: "Learn popular sorting algorithms like QuickSort and MergeSort." },
      { title: "Trees and Graphs", description: "Study tree and graph data structures and their applications." },
      { title: "Dynamic Programming", description: "Understand solving complex problems by breaking them into simpler subproblems." },
      { title: "Greedy Algorithms", description: "Explore algorithms that make locally optimal choices at each step." },
      { title: "Hash Tables", description: "Learn about hash functions and their use in efficient data retrieval." },
      { title: "Recursion", description: "Understand solving problems by breaking them into smaller instances of the same problem." },
      { title: "Search Algorithms", description: "Study algorithms like Binary Search and Depth-First Search." },
      { title: "Complexity Analysis", description: "Learn to analyze time and space complexity of algorithms." },
      { title: "Heap Data Structure", description: "Explore priority queues and their implementation using heaps." },
      { title: "Graph Traversal Algorithms", description: "Understand BFS and DFS for traversing graphs." }
    ]
  },
  {
    title: "Database Systems",
    description: "Understand database design, management, and data retrieval techniques.",
    topics: [
      { title: "Relational Database Design", description: "Learn how to design normalized relational databases." },
      { title: "NoSQL Databases", description: "Explore non-relational database models and their use cases." },
      { title: "SQL Queries", description: "Master writing queries for data retrieval and manipulation." },
      { title: "Indexing and Optimization", description: "Understand techniques for improving database performance." },
      { title: "Transactions and Concurrency Control", description: "Learn about ACID properties and managing concurrent access." },
      { title: "Database Security", description: "Explore methods for securing databases from unauthorized access." },
      { title: "Data Warehousing", description: "Understand designing and managing large-scale data repositories." },
      { title: "Database Backup and Recovery", description: "Learn strategies for data backup and disaster recovery." },
      { title: "Distributed Databases", description: "Explore databases spread across multiple locations." },
      { title: "Database Migration", description: "Understand moving data between different database systems." }
    ]
  },
  {
    title: "Operating Systems",
    description: "Learn the fundamentals of operating system design and implementation.",
    topics: [
      { title: "Memory Management", description: "Understand techniques for memory allocation and virtual memory." },
      { title: "File Systems", description: "Explore how operating systems manage and store files." },
      { title: "Process Scheduling", description: "Learn about algorithms for CPU scheduling." },
      { title: "Inter-Process Communication", description: "Understand mechanisms for processes to communicate." },
      { title: "Deadlock Handling", description: "Explore strategies for detecting and resolving deadlocks." },
      { title: "Device Management", description: "Learn how operating systems manage hardware devices." },
      { title: "Kernel Architecture", description: "Understand the core components of an operating system." },
      { title: "Virtualization", description: "Explore creating virtual versions of hardware, operating systems, and storage." },
      { title: "Security and Protection", description: "Learn about mechanisms to protect system resources." },
      { title: "Real-Time Operating Systems", description: "Understand operating systems designed for real-time applications." }
    ]
  },
  {
    title: "Artificial Intelligence",
    description: "Delve into AI concepts and techniques for intelligent decision-making.",
    topics: [
      { title: "Machine Learning", description: "Study supervised and unsupervised learning algorithms." },
      { title: "Natural Language Processing", description: "Explore techniques for language understanding and generation." },
      { title: "Neural Networks", description: "Understand the architecture and training of neural networks." },
      { title: "Reinforcement Learning", description: "Learn about algorithms that learn by interacting with an environment." },
      { title: "Computer Vision", description: "Explore techniques for image and video analysis." },
      { title: "Expert Systems", description: "Understand rule-based systems that emulate human decision-making." },
      { title: "AI Ethics", description: "Learn about ethical considerations in AI development and deployment." },
      { title: "Robotics", description: "Study the integration of AI in robotic systems." },
      { title: "Genetic Algorithms", description: "Explore optimization techniques inspired by natural selection." },
      { title: "AI in Healthcare", description: "Understand applications of AI in medical diagnosis and treatment." }
    ]
  },
  {
    title: "Computer Networks",
    description: "Learn the principles of network communication and security.",
    topics: [
      { title: "Network Protocols", description: "Study protocols like TCP/IP and HTTP for network communication." },
      { title: "Network Security", description: "Understand techniques for securing networked systems." },
      { title: "Wireless Networks", description: "Explore the design and challenges of wireless communication." },
      { title: "Network Topologies", description: "Learn about different network layouts like star, mesh, and ring." },
      { title: "Routing Algorithms", description: "Understand how data packets are routed across networks." },
      { title: "Quality of Service", description: "Explore techniques for managing network traffic and performance." },
      { title: "Network Virtualization", description: "Learn about creating virtual networks on physical infrastructure." },
      { title: "Internet of Things", description: "Understand connecting everyday devices to the internet." },
      { title: "Cloud Networking", description: "Explore networking in cloud computing environments." },
      { title: "Network Troubleshooting", description: "Learn methods for diagnosing and resolving network issues." }
    ]
  },
  {
    title: "Web Development",
    description: "Develop skills for building modern, responsive web applications.",
    topics: [
      { title: "Front-End Frameworks", description: "Learn about popular frameworks like React and Angular." },
      { title: "Web Performance Optimization", description: "Explore techniques to improve website loading and interactivity." },
      { title: "Responsive Design", description: "Understand creating websites that work on all devices." },
      { title: "Web Accessibility", description: "Learn designing websites usable by people with disabilities." },
      { title: "Back-End Development", description: "Explore server-side programming and database integration." },
      { title: "APIs and RESTful Services", description: "Understand designing and consuming web APIs." },
      { title: "Web Security", description: "Learn about common vulnerabilities and how to prevent them." },
      { title: "Content Management Systems", description: "Explore platforms like WordPress for managing web content." },
      { title: "Progressive Web Apps", description: "Understand building web apps that work offline." },
      { title: "Web Sockets", description: "Learn about real-time communication between clients and servers." }
    ]
  },
  {
    title: "Cybersecurity",
    description: "Gain knowledge of strategies to protect systems and data from threats.",
    topics: [
      { title: "Ethical Hacking", description: "Learn penetration testing methods to identify vulnerabilities." },
      { title: "Encryption Techniques", description: "Explore algorithms for encrypting and securing data." },
      { title: "Firewalls and Intrusion Detection", description: "Understand tools for monitoring and blocking threats." },
      { title: "Malware Analysis", description: "Learn about identifying and analyzing malicious software." },
      { title: "Identity and Access Management", description: "Explore controlling user access to systems." },
      { title: "Security Policies", description: "Understand creating and enforcing security guidelines." },
      { title: "Incident Response", description: "Learn strategies for responding to security breaches." },
      { title: "Digital Forensics", description: "Explore techniques for investigating cybercrimes." },
      { title: "Cloud Security", description: "Understand securing data and applications in the cloud." },
      { title: "Zero Trust Architecture", description: "Learn about security models that assume no implicit trust." }
    ]
  },
  {
    title: "Human Computer Interaction",
    description: "Understand how users interact with technology to design better interfaces.",
    topics: [
      { title: "Usability Testing", description: "Learn methods for evaluating users experience." },
      { title: "UI/UX Design Principles", description: "Explore design principles for creating users-friendly interfaces." },
      { title: "Information Architecture", description: "Understand organizing and structuring information effectively." },
      { title: "Interaction Design", description: "Learn designing interactive and engaging user interfaces." },
      { title: "User Research", description: "Explore techniques for understanding user needs and behaviors." },
      { title: "Prototyping", description: "Understand creating mockups and prototypes for testing designs." },
      { title: "Visual Design", description: "Learn about aesthetics and visual elements in interface design." },
      { title: "Accessibility in Design", description: "Explore making interfaces usable for all users." },
      { title: "Cognitive Psychology in HCI", description: "Understand how human cognition influences design." },
      { title: "Mobile Interface Design", description: "Learn designing interfaces for mobile devices." }
    ]
  },
  {
    title: "Cloud Computing",
    description: "Study cloud architecture, services, and deployment models.",
    topics: [
      { title: "Cloud Service Models", description: "Understand IaaS, PaaS, and SaaS cloud service models." },
      { title: "Containerization", description: "Learn about container technologies like Docker and Kubernetes." },
      { title: "Serverless Computing", description: "Explore running applications without managing servers." },
      { title: "Cloud Storage", description: "Understand scalable and secure storage solutions in the cloud." },
      { title: "Cloud Security", description: "Learn about protecting data and applications in the cloud." },
      { title: "Cloud Migration", description: "Explore strategies for moving applications to the cloud." },
      { title: "Multi-Cloud Strategies", description: "Understand using multiple cloud providers for redundancy and flexibility." },
      { title: "Cloud Cost Management", description: "Learn techniques for optimizing cloud expenses." },
      { title: "Edge Computing", description: "Explore processing data closer to the source to reduce latency." },
      { title: "Cloud Monitoring and Management", description: "Understand tools for managing cloud resources and performance." }
    ]
  }
]

units.each do |unit_data|
  unit = Unit.create!(
    title: unit_data[:title],
    description: unit_data[:description],
    course: course
  )

  pdf_filename = unit.title.downcase.gsub(" ", "_") + ".pdf"
  pdf_path = Rails.root.join('seed_pdfs', pdf_filename)

  puts "PDF PATH #{pdf_path}"

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
          filename: pdf_filename,
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
Enrollment.find_or_create_by!(user: admin, course: course)
Enrollment.find_or_create_by!(user: staff, course: course)
students.each do |student|
  Enrollment.find_or_create_by!(user: student, course: course)
end

puts "Seed completed successfully!"

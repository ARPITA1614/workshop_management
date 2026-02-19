# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "Cleaning out old workshop data..."
# This command deletes every row in the workshops table
Workshop.destroy_all 

puts "Creating fresh Workshop records..."
puts "Workshops are being created"

workshops = Workshop.create([
  {
  name: "Full Stack ROR Development BootCamp",
  description: "It is very good workshop must attend it. It will increase your knowledge",
  start_date: Date.today + 35.days,
  end_date: Date.today + 45.days,
  start_time: "10:00 AM",
  end_time: "3:00 PM",
  total_sits: 100,
  remaining_sits: 100,
  registration_fee: 1500
},
 {
  name: "Full Stack Mern Stack Development BootCamp",
  description: "It is very good workshop must attend it. It will increase your knowledge",
  start_date: Date.today + 40.days,
  end_date: Date.today + 50.days,
  start_time: "11:00 AM",
  end_time: "4:00 PM",
  total_sits: 80,
  remaining_sits: 80,
  registration_fee: 2000
},
 {
  name: "Full Stack using Python Development BootCamp",
  description: "It is very good workshop must attend it. It will increase your knowledge",
  start_date: Date.today + 52.days,
  end_date: Date.today + 62.days,
  start_time: "12:00 AM",
  end_time: "4:00 PM",
  total_sits: 100,
  remaining_sits: 100,
  registration_fee: 2000
}

])

# Dummy workshop records
# drop your databas eand then reset it. 

workshops = Workshop.create([
  {
    name: 'Ruby on Rails Full Stack Development Bootcamp',
    description: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
    start_date: Date.today + 45.days,
    end_date: Date.today + 55.days,
    start_time: '10:00 AM',
    end_time: '4:00 PM',
    total_sits: 100,
    remaining_sits: 100,
    registration_fee: 500
  },
  {
    name: 'Node Js Full Stack Development Bootcamp',
    description: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
    start_date: Date.today + 60.days,
    end_date: Date.today + 70.days,
    start_time: '10:00 AM',
    end_time: '4:00 PM',
    total_sits: 100,
    remaining_sits: 100,
    registration_fee: 450
  },
  {
    name: 'Ruby on Rails Ninja Bootcamp',
    description: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
    start_date: Date.today + 50.days,
    end_date: Date.today + 60.days,
    start_time: '10:00 AM',
    end_time: '4:00 PM',
    total_sits: 100,
    remaining_sits: 100,
    registration_fee: 750
  },
  {
    name: 'Ruby on Rails Full  - Learn Real World Web Development',
    description: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
    start_date: Date.today + 55.days,
    end_date: Date.today + 62.days,
    start_time: '10:00 AM',
    end_time: '4:00 PM',
    total_sits: 100,
    remaining_sits: 100,
    registration_fee: 500
  },
  {
    name: 'Ruby on Rails Meetup conference',
    description: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
    start_date: Date.today + 105.days,
    end_date: Date.today + 108.days,
    start_time: '10:00 AM',
    end_time: '4:00 PM',
    total_sits: 250,
    remaining_sits: 250,
    registration_fee: 1000
  },
  {
    name: 'Rails Beginners Bootcamp',
    description: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
    start_date: Date.today + 150.days,
    end_date: Date.today + 165.days,
    start_time: '10:00 AM',
    end_time: '4:00 PM',
    total_sits: 400,
    remaining_sits: 400,
    registration_fee: 2000
  },
  {
    name: 'Machine Learning and Data Science Using Python and R - Ninja Bootcamp',
    description: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
    start_date: Date.today + 92.days,
    end_date: Date.today + 99.days,
    start_time: '10:00 AM',
    end_time: '4:00 PM',
    total_sits: 250,
    remaining_sits: 250,
    registration_fee: 1000
  },
  {
    name: 'The Ruby Conf 2022',
    description: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
    start_date: Date.today + 86.days,
    end_date: Date.today + 90.days,
    start_time: '10:00 AM',
    end_time: '4:00 PM',
    total_sits: 250,
    remaining_sits: 250,
    registration_fee: 1000
  },
  {
    name: 'A Tour To Ruby Programming Language',
    description: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
    start_date: Date.today - 19.days,
    end_date: Date.today - 12.days,
    start_time: '10:00 AM',
    end_time: '4:00 PM',
    total_sits: 250,
    remaining_sits: 0,
    registration_fee: 1000
  },
  {
    name: 'A Tour To Ruby on Rails Web Development Framework',
    description: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
    start_date: Date.today - 29.days,
    end_date: Date.today - 22.days,
    start_time: '10:00 AM',
    end_time: '4:00 PM',
    total_sits: 250,
    remaining_sits: 0,
    registration_fee: 1000
  },
  {
    name: 'Building Real World Apps with Ruby on Rails',
    description: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
    start_date: Date.today - 50.days,
    end_date: Date.today - 37.days,
    start_time: '10:00 AM',
    end_time: '4:00 PM',
    total_sits: 250,
    remaining_sits: 0,
    registration_fee: 1000
  },
  {
    name: 'A Tour To Ruby on Rails Web Development Framework',
    description: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
    start_date: Date.today - 29.days,
    end_date: Date.today - 22.days,
    start_time: '10:00 AM',
    end_time: '4:00 PM',
    total_sits: 250,
    remaining_sits: 0,
    registration_fee: 1000
  },
  {
    name: 'DSA using Java',
    description: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
    start_date: Date.today - 29.days,
    end_date: Date.today - 22.days,
    start_time: '10:00 AM',
    end_time: '4:00 PM',
    total_sits: 250,
    remaining_sits: 250,
    registration_fee: 1000
  },
  {
    name: 'Mern Stack',
    description: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
    start_date: Date.today - 29.days,
    end_date: Date.today - 22.days,
    start_time: '10:00 AM',
    end_time: '4:00 PM',
    total_sits: 250,
    remaining_sits: 250,
    registration_fee: 1000
  },
  {
    name: 'A Tour To PHP',
    description: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
    start_date: Date.today - 29.days,
    end_date: Date.today - 22.days,
    start_time: '10:00 AM',
    end_time: '4:00 PM',
    total_sits: 250,
    remaining_sits: 250,
    registration_fee: 1000
  },
  {
    name: 'A Tour To .NET',
    description: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
    start_date: Date.today - 29.days,
    end_date: Date.today - 22.days,
    start_time: '10:00 AM',
    end_time: '4:00 PM',
    total_sits: 250,
    remaining_sits: 0,
    registration_fee: 1000
  }
])

puts "Workshop has been created"
puts "Admin creating or updating"
admin=AdminUser.find_or_initialize_by!(email: "arpitadmn@gmail.com") 
  admin.password = "password"
  admin.password_confirmation = "password"
  admin.save!
  puts "Admin ready !!!!!!!"
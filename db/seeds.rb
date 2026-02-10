# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Workshops are being created"
workshops = Workshop.create([
  {
  name: "Full Stack ROR Development BootCamp",
  description: "It is very good workshop must attend it. It will increase your knowledge",
  start_date: Date.today + 5.days,
  end_date: Date.today + 10.days,
  start_time: "10:00 AM",
  end_time: "3:00 PM",
  total_sits: 100,
  remaining_sits: 0,
  registration_fee: 1500
},
 {
  name: "Full Stack Mern Stack Development BootCamp",
  description: "It is very good workshop must attend it. It will increase your knowledge",
  start_date: Date.today + 10.days,
  end_date: Date.today + 15.days,
  start_time: "11:00 AM",
  end_time: "4:00 PM",
  total_sits: 80,
  remaining_sits: 0,
  registration_fee: 2000
},
 {
  name: "Full Stack using Python Development BootCamp",
  description: "It is very good workshop must attend it. It will increase your knowledge",
  start_date: Date.today + 12.days,
  end_date: Date.today + 20.days,
  start_time: "12:00 AM",
  end_time: "4:00 PM",
  total_sits: 100,
  remaining_sits: 0,
  registration_fee: 2000
}

])

puts "Workshop has been created"
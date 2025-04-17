# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "Truncating Roles and Users"
Role.destroy_all
User.destroy_all

puts "Running seeds..."
puts "Creating roles..."
['student', 'teacher', 'admin'].each do |role|
    Role.find_or_create_by(name: role)
end


puts "Creating admin..."
User.create(
    :name => "Admin",
    :email => "admin@usac.edu.gt",
    :password => "12345678",
    :role => Role.find_by(name: "admin")
)

puts "Finished seeding database"
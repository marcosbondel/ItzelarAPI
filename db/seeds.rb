puts "Running seeds..."
puts "Creating roles..."
['student', 'professor', 'admin'].each do |role|
    Role.find_or_create_by(name: role)
end

puts "Creating admin..."
User.create(
    :name => "Admin",
    :email => "admin@usac.edu.gt",
    :password => "admin",
    :role => Role.find_by(name: "admin")
)
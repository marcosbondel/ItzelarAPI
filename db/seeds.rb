puts "Running seeds..."
puts "Creating roles..."
[
    {
        :name => 'admin',
        :default_path => '/admin'
    }, 
    {
        :name => 'professor',
        :default_path => '/teacher'
    }, 
    {
        :name => 'student',
        :default_path => '/student'
    }, 
].each do |role|
    Role.create!(name: role[:name], default_path: role[:default_path] )
end

puts "Creating admin..."
User.create!(
    :name => "Admin",
    :email => "admin@usac.edu.gt",
    :password => "Admin1234#",
    :role => Role.find_by(name: "admin")
)
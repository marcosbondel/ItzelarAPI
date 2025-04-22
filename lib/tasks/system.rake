namespace :system do
    desc "Setting up API"
    task setup: :environment do
        puts "Setting up system..."

        schema_file = Rails.root.join("db", "schema.rb")

        if File.exist?(schema_file)
            File.delete(schema_file)
            puts "Deleted schema.rb"
        else
            puts "schema.rb not found, nothing to delete"
        end

        puts "Installing gems."
        system("bundle install")
        Rake::Task["db:drop"].invoke
        Rake::Task["db:create"].invoke
        Rake::Task["db:migrate"].invoke
        Rake::Task["db:seed"].invoke
        puts "System setup complete."
    end
end
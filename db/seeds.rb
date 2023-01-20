# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# for seed data, look in the /db/seed folder and store your seed file(s) there

# loads all .rb files in the seed folder
unless Rails.env.production?
  Dir[File.dirname(__FILE__) + '/seed/*.rb'].each {|file| require file } 
else
  puts "did you really try to seed production?"
end

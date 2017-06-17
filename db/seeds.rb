# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts 'Beginning to create seeds.....'
puts '******************************'

puts 'Creating 10 customers'

10.times do
  c = Customer.new(
    firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    email: Faker::Internet.unique.email
    # avatar: File.new("#{Rails.root}/app/assets/images/customers/
    )
  c.save!
end
puts 'Finished creating customers'

puts '******************************'

puts 'Creating 50 books'
50.times do
  b = Book.new(
    title: Faker::Book.unique.title,
    author: Faker::Book.author,
    summary: Faker::Lorem.sentences(rand(2..7))
    )
  b.save!
end

puts 'Finished creating books'

puts '******************************'
puts 'Seeds complete!'

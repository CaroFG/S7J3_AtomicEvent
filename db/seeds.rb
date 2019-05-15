# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#  movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#  Character.create(name: 'Luke', movie: movies.first)
require 'faker'
User.destroy_all
Event.destroy_all
#----------------On crée nos users et nos events -----------------
10.times do
  @user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name, 
    email: Faker::Internet.email,
    description: Faker::Movie.quote, 
    password: Faker::Internet.password
    )  
  puts 'user added'
  @user.avatar.attach(io: File.open('app/assets/images/event.jpg'), filename: 'event.jpg')
  @event = Event.new(
    start_date: "2019-06-21 19:00",
    duration: 50,
    title: Faker::Movie.quote,
    description: Faker::Lorem.paragraph_by_chars(55, false),
    price: rand(1..1000),
    location: Faker::Address.city,
    admin: @user
    )
  
  # A supprimer, gardé pour tests
  @event.update(validated:true)
  @event.picture.attach(io: File.open('app/assets/images/event.jpg'), filename: 'event.jpg')
  @event.save
  puts 'Event added'
end
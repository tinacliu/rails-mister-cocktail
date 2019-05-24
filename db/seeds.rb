# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'

puts 'Cleaning database...'

Cocktail.destroy_all
Dose.destroy_all
Ingredient.destroy_all

puts 'creating ingredients'

response = open('https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list')
json = JSON.parse(response.read)

p json['drinks']

json['drinks'].each do |hash|
  puts "creating #{hash['strIngredient1']}"
  Ingredient.create!(name: hash['strIngredient1'])
end

puts 'creating 1 cocktail and 1 dose'

@cocktail = Cocktail.create!(name: "Thyme Delight")

@dose1 = Dose.new(description: "40g")
@ice = Ingredient.find_by(name: "Ice")
@dose1.cocktail = @cocktail
@dose1.ingredient = @ice
@dose1.save

@cocktail = Cocktail.create!(name: "Sonoma")
@cocktail = Cocktail.create!(name: "Gin & Tonic")

puts 'finished'

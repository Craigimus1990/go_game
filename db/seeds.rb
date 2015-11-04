# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

p1 = Player.create({ :name => "Player_1" })
p2 = Player.create({ :name => "Player_2" })

Game.create({ :board => [], :turn => 1, :black_player => p1, :white_player => p2})


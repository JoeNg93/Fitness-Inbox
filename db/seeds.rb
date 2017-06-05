# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Client.create(name: 'Joe', email: 'ntuandung93@gmail.com', role: 'user', password: 'foobar', password_confirmation: 'foobar')
Client.create(name: 'Robert', email: 'hihihaha@gmail.com', role: 'user', password: 'foobar', password_confirmation: 'foobar')

Message.create(content: 'Hii', sender_id: Client.first.id, receiver_id: Client.second.id)


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Client.create(name: 'Joe', email: 'ntuandung93@gmail.com', role: 'user', password: 'foobar', password_confirmation: 'foobar')
Client.create(name: 'Robert', email: 'hihihaha@gmail.com', role: 'user', password: 'foobar', password_confirmation: 'foobar')
Client.create(name: 'Mark', email: 'marktheman@gmail.com', role: 'trainer', password: 'foobar', password_confirmation: 'foobar')

Message.create(content: "Hi Robert! It's Joe", sender_id: Client.find_by(name: 'Joe').id, receiver_id: Client.find_by(name: 'Robert').id)
Message.create(content: "Hi Mark! It's Joe", sender_id: Client.find_by(name: 'Joe').id, receiver_id: Client.find_by(name: 'Mark').id)

Message.create(content: "Hi Joe! It's Robert", sender_id: Client.find_by(name: 'Robert').id, receiver_id: Client.find_by(name: 'Joe').id)
Message.create(content: "Hi Mark! It's Robert", sender_id: Client.find_by(name: 'Robert').id, receiver_id: Client.find_by(name: 'Mark').id)

Message.create(content: "Hi Joe! It's Mark", sender_id: Client.find_by(name: 'Mark').id, receiver_id: Client.find_by(name: 'Joe').id)
Message.create(content: "Hi Robert! It's Mark", sender_id: Client.find_by(name: 'Mark').id, receiver_id: Client.find_by(name: 'Robert').id)

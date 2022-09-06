# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.delete_all
User.create!([
               {
                 email: 'mpoppins@gmail.com',
                 first_name: 'Marry',
                 last_name: 'Poppins',
                 password: 'xxx',
                 group: 2
               },
               {
                 email: 'mbanks@gmail.com',
                 first_name: 'Michael',
                 last_name: 'Banks',
                 password: 'xxx',
                 group: 0,
                 latitude: 42.604715,
                 longitude: -83.938629
               },
               {
                 email: 'jbanks@gmail.com',
                 first_name: 'Jane',
                 last_name: 'Banks',
                 password: 'xxx',
                 group: 0,
                 latitude: 42.527468,
                 longitude: -83.787242
               }
             ])

Interest.delete_all
Interest.create!([
                   { title: 'Board Games', description: '' },
                   { title: 'Camping', description: '' },
                   { title: 'Photography', description: '' },
                   { title: 'Road Trips', description: '' }
                 ])

michael = User.find_by(email: 'mbanks@gmail.com')
jane = User.find_by(email: 'jbanks@gmail.com')

Conversation.delete_all
c = Conversation.create!(
  author_id: michael.id,
  recipient_id: jane.id
)
c.messages.create!(author_id: michael.id, content: 'This is a message!')
c.messages.create!(author_id: jane.id, content: 'This is a response...')

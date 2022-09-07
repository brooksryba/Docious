# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

GEO_FACTORY = RGeo::Geographic.spherical_factory(srid: 4326)

Interest.delete_all
Interest.create!([
  { title: 'Board Games', description: '' },
  { title: 'Camping', description: '' },
  { title: 'Photography', description: '' },
  { title: 'Road Trips', description: '' }
])

User.delete_all
User.create!([
  { email: 'mpoppins@gmail.com', first_name: 'Marry', last_name: 'Poppins', password: 'xxx', group: 2, birthdate: Date.new(1984, 1, 1) },
  { email: 'mbanks@gmail.com', first_name: 'Michael', last_name: 'Banks', password: 'xxx', group: 0, birthdate: Date.new(1999, 2, 1), latlon: GEO_FACTORY.point(42.604715, -83.938629) },
  { email: 'jbanks@gmail.com', first_name: 'Jane', last_name: 'Banks', password: 'xxx', group: 0, birthdate: Date.new(1998, 3, 1), latlon: GEO_FACTORY.point(42.527468, -83.787242) }
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

Preference.delete_all
Preference.create!(user_id: michael.id, max_distance: 1.0, min_age: 20, max_age: 25)
Preference.create!(user_id: jane.id, max_distance: 0.1, min_age: 23, max_age: 24)

Profile.delete_all
Profile.create!(user_id: michael.id, nickname: "Mike", biography: "This is my bigraphy. I like to do things.", interests: [Interest.find_by(title: "Board Games").id])
Profile.create!(user_id: jane.id, nickname: "Janey", biography: "Learn all about me. This is my profile.", interests: [Interest.find_by(title: "Photography").id])
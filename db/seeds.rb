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
                 email: 'poppins@gmail.com',
                 first_name: 'Marry',
                 last_name: 'Poppins'
               }
             ])

Interest.delete_all
Interest.create!([
                   { title: 'Board Games', description: '' },
                   { title: 'Camping', description: '' },
                   { title: 'Photography', description: '' },
                   { title: 'Road Trips', description: '' }
                 ])

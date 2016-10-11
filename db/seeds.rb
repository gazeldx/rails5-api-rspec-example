# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Customer.create(email: 'zjloveztt@gmail.com', token: 'token1', full_name: 'Lane Zhang', password_digest: BCrypt::Password.create('password1').to_s, description: 'RoR and JS full stack developer')
Customer.create(email: 'brucewang@163.com', token: 'token2', full_name: 'Bruce Lee', password_digest: BCrypt::Password.create('password2').to_s, description: 'Best Sales')
Customer.create(email: 'jetlee@163.com', token: 'token3', full_name: 'Jet Lee', password_digest: BCrypt::Password.create('password3').to_s, description: 'I love Taiji')

Agent.create(email: 'jackiechan@agent123.com', token: 'token3', full_name: 'Jackie Chan', password_digest: BCrypt::Password.create('password3').to_s, description: 'He will give it a shot.')
Agent.create(email: 'wang@123.com', token: 'token5', full_name: 'Hegwin Wang', password_digest: BCrypt::Password.create('password5').to_s, description: "Hegwin's oral English is good.")

Administrator.create(email: 'admin@admin.com', token: 'token6', full_name: 'Alex', password_digest: BCrypt::Password.create('password6').to_s, description: "Alex's administrator.")

Ticket.create(customer_id: 1, title: 'I lost my shoes.', content: 'When I was skating yesterday.')


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Administrator.delete_all
Customer.delete_all
Agent.delete_all
Ticket.delete_all

Customer.create(email: 'billgates@microsoft.com',
                token: 'token1',
                full_name: 'Bill Gates',
                password_digest: BCrypt::Password.create('password1').to_s,
                description: 'President of Microsoft')
Customer.create(email: 'stevejobs@apple.com',
                token: 'token2',
                full_name: 'Steve Jobs',
                password_digest: BCrypt::Password.create('password2').to_s,
                description: 'Soul of Apple')
Customer.create(email: 'larryellison@oracle.com',
                token: 'token3',
                full_name: 'Larry Ellison',
                password_digest: BCrypt::Password.create('password3').to_s,
                description: 'Oracle captain')

Agent.create(email: 'jetlee@agent.com',
             token: 'token1',
             full_name: 'Jet Lee',
             password_digest: BCrypt::Password.create('password1').to_s,
             description: 'I like Charities.')
Agent.create(email: 'jackiechan@agent.com',
             token: 'token2',
             full_name: 'Jackie Chan',
             password_digest: BCrypt::Password.create('password2').to_s,
             description: 'I rarely use substitute.')
Agent.create(email: 'jimcarrey@agent.com',
             token: 'token3',
             full_name: 'Jim Carrey',
             password_digest: BCrypt::Password.create('password3').to_s,
             description: 'If I could intrude a note of seriousness into this frivolous conversation.')

Administrator.create(email: 'admin@agent.com',
                     token: 'token1',
                     full_name: 'John Johns',
                     password_digest: BCrypt::Password.create('password1').to_s,
                     description: "I am on vacation.")

Ticket.create(customer_id: 1, title: 'I lost my shoes.', content: 'When I was skating yesterday.')
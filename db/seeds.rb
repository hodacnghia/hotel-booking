# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
r1 = Role.create({name: "Regular", description: "Can read items"})
r2 = Role.create({name: "Admin", description: "Can perform any CRUD operation on any resource"})


u2 = User.create({name: "Hien", email: "hien@gmail.com", password: "123456", password_confirmation: "123456", role_id: r1.id})
u3 = User.create({name: "Nguyen", email: "nguyen@gmail.com", password: "123456", password_confirmation: "123456", role_id: r1.id})
u4 = User.create({name: "Nghia", email: "nghia@gmail.com", password: "123456", password_confirmation: "123456", role_id: r2.id})

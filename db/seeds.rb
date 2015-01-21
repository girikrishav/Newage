# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.destroy_all
Role.create(name: 'Administrator', rank: 100)
Role.create(name: 'Manager', rank: 50)
Role.create(name: 'User', rank: 1)

AdminUser.destroy_all
@role = Role.find_by_name('Administrator')
AdminUser.create(email: 'admin@example.com', password: 'password', password_confirmation: 'password', role_id: @role.id)
@role = Role.find_by_name('Manager')
AdminUser.create(email: 'manager@example.com', password: 'password', password_confirmation: 'password', role_id: @role.id)
@role = Role.find_by_name('User')
AdminUser.create(email: 'user@example.com', password: 'password', password_confirmation: 'password', role_id: @role.id)

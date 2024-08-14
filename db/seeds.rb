# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create(name: "Jorge",   email: "jorge@mata.cr",   role: "admin", password: "password123")
User.create(name: "Marilyn", email: "marilyn@mata.cr", role: "admin", password: "password123")
User.create(name: "Anibal",  email: "anibal@mata.cr",  role: "basic", password: "password123")
User.create(name: "Amanda",  email: "amanda@mata.cr",  role: "basic", password: "password123")

Customer.create(name: "Auri",    surname: "Buendia", cx_id: "0305171")
Customer.create(name: "Suliko",  surname: "Rey",     cx_id: "0305172")
Customer.create(name: "Kalinka", surname: "Mayá",    cx_id: "1206191")
Customer.create(name: "Mochi",   surname: "Galileo", cx_id: "1125201")
Customer.create(name: "Shiho",   surname: "Tomasa",  cx_id: "0225221")
Customer.create(name: "Joshua",  surname: "Pascal",  cx_id: "0225222")

Customer.update_all(created_by_id: User.first.id, updated_by_id: User.first.id)

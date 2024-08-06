# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
p "=========== Seeding the Database ============="

p "+ Adding some people..."
[
  { first_name: "John", last_name: "Snow" },
  { first_name: "Hommer", last_name: "Simpson" },
  { first_name: "John", last_name: "Doe" },
  { first_name: "Joe", last_name: "Black" }
].each do |person|
  Person.find_or_create_by!(first_name: person[:first_name], last_name: person[:last_name])
end

p "+ Adding a handfull of businesses..."
["Capsule Corp", "Sand Castle", "Cuack University"].each do |name|
  Business.find_or_create_by!(name: name)
end

Business.all.each do |business|
  business.business_members.find_or_create_by!(person: Person.first)
end

p "+ Adding some branch locations..."
["123 One St", "345 Secure Rd", "45 Black Rock Dr", "237 Wolf Ave"].each do |address|
  BranchOffice.find_or_create_by!(street_address: address) do |branch|
    branch.city = "City#{(Random.rand * 100).to_i}"
  end
end

p "+ Creating some bank accounts..."
Account.create(balance: 0.00, owner: Person.last, branch_office: BranchOffice.first)

p "+ Adding some spice with a few transactions..."

p "=========== DONE ============="

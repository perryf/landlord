### NOTE: Make sure you've loaded the seeds.sql file into your DB before starting
### this exercise

require "pg" # postgres db library
require "active_record" # the ORM
require "pry" # for debugging

ActiveRecord::Base.establish_connection(
  :adapter => "postgresql",
  :database => "landlord"
)

class Tenant < ActiveRecord::Base
  belongs_to :apartment
end

class Apartment < ActiveRecord::Base
  has_many :tenants
end

################################################
#### NOTE: DON'T MODIFY ABOVE THIS LINE     ####
################################################


################################################
# FINDING / SELECTING
################################################

# Hint, the following methods will help: `where`, `all`, `find`, `find_by`

# Use Active record to do the following, and store the results **in a variable**
# example: get every tenant in the DB
all_tenants = Tenant.all

# get the first tenant in the DB
first = Tenant.first
# get all tenants older than 65
old_folks = Tenant.where("age > 65")
# get all apartments whose price is greater than $2300
pricey_joints = Apartment.where("monthly_rent > 2300")
# get the apartment with the address "6005 Damien Corners"
damien = Apartment.find_by(address: "6005 Damien Corners")
# get all tenants in that apartment
damien_folks = Tenant.where(apartment_id: 6)
# Use `each` and `puts` to:
# Display the name and ID # of every tenant
names_ids = Tenant.all.each{|tenant| puts tenant.name + " " + tenant.age.to_s}
# Iterate over each apartment, for each apartment, display it's address and rent price
addy_rent = Apartment.all.each {|i| puts "Address: #{i.address} Rent: #{i.monthly_rent}"}
# Iterate over each apartment, for each apartment, display it's address and all of it's tenants
addy_tenants = Apartment.all.each do |i|
  puts i.address
  i.tenants.each{|p| puts p.name}
end
################################################
# CREATING / UPDATING / DELETING
################################################

# Hint, the following methods will help: `new`, `create`, `save`, `uddate`, `destroy`

# Create 3 new apartments, and save them to the DB
fun_house1 = Apartment.create(address: "123 Fake St", monthly_rent: 2000, sqft: 1000, num_beds: 2, num_baths: 2)

fun_house2 = Apartment.create(address: "321 Fake St", monthly_rent: 3000, sqft: 1, num_beds: 1, num_baths: 2)

fun_house3 = Apartment.create(address: "666 Fake St", monthly_rent: 4000, sqft: 2, num_beds: 2, num_baths: 200)

# Create at least 9 new tenants and save them to the DB. (Make sure they belong to an apartment)
# Note: you'll use this little bit of code as a `seeds.rb` file later on.

ten1 = Tenant.create(name: "Sally", age: 42, gender: female, apartment_id: 1)
ten2 = Tenant.create(name: "Marty", age: 30, gender: male, apartment_id: 2)
ten3 = Tenant.create(name: "Egbert", age: 100, gender: female, apartment_id: 4)
ten4 = Tenant.create(name: "Bertha", age: 200, gender: male, apartment_id: 5)
ten5 = Tenant.create(name: "Dilly", age: 69, gender: female, apartment_id: 6)
ten6 = Tenant.create(name: "Derpy", age: 24, gender: male, apartment_id: 10)
ten7 = Tenant.create(name: "WakaWaka", age: 2, gender: female, apartment_id: 12)
ten8 = Tenant.create(name: "Sloopy", age: 55, gender: male, apartment_id: 13)
ten9 = Tenant.create(name: "Sloppy", age: 76, gender: female, apartment_id: 13)

# Birthday!
# It's Kristin Wisoky's birthday. Find her in the DB and change her age to be 1 year older
# Note: She's in the seed data, so she should be in your DB

kristin = Tenant.find_by(name: "Kristin Wisoky")
kristin.age += 1
kristin.save

# Rennovation!
# Find the apartment "62897 Verna Walk" and update it to have an additional bedroom
# Make sure to save the results to your database

verna = Apartment.find_by(address: "62897 Verna Walk")
verna.num_beds += 1
verna.save

# Rent Adjustment!
# Update the same apartment that you just 'rennovated'. Increase it's rent by $400
# to reflect the new bedroom
verna = Apartment.find_by(address: "62897 Verna Walk")
verna.monthly_rent += 400
verna.save

# Millenial Eviction!
# Find all tenants who are under 30 years old
# Delete their records from the DB
millenials = Tenant.where("age < 30")
millenials.delete_all

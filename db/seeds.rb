# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# require 'csv'    

# csv_text = File.read('db/data-small.csv')
# csv = CSV.parse(csv_text, :headers => true)

# csv.each do |row|
#   #Moulding.create!(row.to_hash)

#   if !row["title"].nil? && !row["location"].nil? && !row["dates"].nil?
#   	title = row["title"]
#   	address = row["location"]
#   	tags = title.split(/\W+/)
#   	exception = ["the", "The", "is"]
#   	tags_list = tags-exception
#   	event = Event.create(name: title, full_street_address: address)
#   end


# end

10.times do |i|
		user = User.create(
				email: Faker::Internet.email, 
				username: Faker::Name.name, avatar: "", 
				password: Devise.friendly_token[0,20], 
				full_street_address: Faker::Address.street_address,
				gender: ["m","f"].sample,
				about: Faker::Lorem.sentences(1)
		)

		user.tag_list.add(["Music", "Dance", "HipHop", "Basketball"], parse:true)
		user.save
end


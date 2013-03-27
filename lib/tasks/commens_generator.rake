
desc "Generate 100 cars"
task generate_cars: :environment  do
	100.times do
		Car.create(make: Faker::Name.first_name, description: Faker::Lorem.paragraph)
	end
end
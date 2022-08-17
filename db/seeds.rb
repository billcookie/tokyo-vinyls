require "discogs"
require "faker"
puts "destroying sweet good music....."
puts "destroying big bad users....."
puts "destroying juicy offers....."
puts "destroying cool bookings...."
Booking.destroy_all
Offer.destroy_all
Vinyl.destroy_all
User.destroy_all
# List.destroy_all
puts "seeding sweet good music....."
puts "seeding users....."
puts "seeding offers....."
puts "seeding bookings...."
# the Le Wagon copy of the API
wrapper = Discogs::Wrapper.new("Tokyo Vinyls", user_token: ENV["DISCOGS_TOKEN"])

artist_ids = [2508414, 65049, 304053, 3852273]

artist_ids.each do |artist_id|
  data = wrapper.get_artist_releases(artist_id)
  data["releases"].each do |release|
    Vinyl.create!(
      name: release["title"],
      artist: release['artist'],
      publishing_year: release["year"],
      img_url: release["thumb"]
    )
  end
end

10.times do
  User.create!(
    email: Faker::Internet.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: "123123"
  )
end

User.create!(
  email: "billcook8122@gmail.com",
  password: "123123",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name
)

User.create!(
  email: "willmes.carla@gmail.com",
  password: "123123",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name
)

User.create!(
  email: "ayakayakaaaa@gmail.com",
  password: "123123",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name
)

User.create!(
  email: "jdchappelow@gmail.com",
  password: "123123",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name
)

User.all.each do |user|
  offer = Offer.new(
    price: [100, 200, 300].sample,
    user: user,
    description: Faker::Quotes::Shakespeare.hamlet_quote,
    vinyl: Vinyl.all.sample,
    condition: ["good", "bad", "ok"].sample,
    location: Faker::Address.city
  )
  offer.save!
end

User.all.each do |user|
  booking = Booking.new(
    user: user,
    offer: Offer.where.not(id: user.offers).sample,
    start_date: Date.today + rand(5..10),
    end_date: Date.today + rand(11..15)
  )
  booking.save!
end


puts "finished seeding sweet good music"
puts "finished seeding users"
puts "finished seeding offers"
puts "finished seeding booking"


# search = wrapper.search("Elton John", :per_page => 10, :type => :artist)

# artist          = wrapper.get_artist("329937")
# artist_releases = wrapper.get_artist_releases("329937")
# release         = wrapper.get_release("1529724")
# label           = wrapper.get_label("29515")





# when searching with artist:
# image is called "cover_image"


# Artist_releases for image "thumb"

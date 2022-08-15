require "discogs"
require "faker"
puts "destroying sweet good music"
puts "destroying users"
puts "destroying offers"
Offer.destroy_all
Vinyl.destroy_all
User.destroy_all
# List.destroy_all
puts "seeding sweet good music"
puts "seeding users"
puts "seeding offers"
# the Le Wagon copy of the API
wrapper = Discogs::Wrapper.new("Tokyo Vinyls", user_token: ENV["DISCOGS_TOKEN"])

artist_ids = [2508414]

artist_ids.each do |artist_id|
  data = wrapper.get_artist_releases(artist_id)
  data["releases"].each do |release|
    Vinyl.create!(
      name: release["title"],
      artist: release['artist'],
      publishing_year: release["year"]
    )
  end
end

10.times do
  User.create!(
    email: Faker::Internet.email,
    password: "123123"
  )
end

User.create!(
  email: "billcook8122@gmail.com",
  password: "123123"
)

User.create!(
  email: "willmes.carla@gmail.com",
  password: "123123"
)

User.create!(
  email: "ayakayakaaaa@gmail.com",
  password: "123123"
)

User.create!(
  email: "jdchappelow@gmail.com",
  password: "123123"
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

puts "finished seeding sweet good music"
puts "finished seeding users"
puts "finished seeding offers"


# search = auth_wrapper.search("Necrovore", :per_page => 10, :type => :artist)

# artist          = wrapper.get_artist("329937")
# artist_releases = wrapper.get_artist_releases("329937")
# release         = wrapper.get_release("1529724")
# label           = wrapper.get_label("29515")

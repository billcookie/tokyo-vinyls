require "discogs"
require "faker"
require "yaml"
puts "destroying sweet good music....."
puts "destroying big bad users....."
puts "destroying juicy offers....."
puts "destroying cool bookings...."
Booking.destroy_all
Offer.destroy_all
Vinyl.destroy_all
Artist.destroy_all
User.destroy_all
# List.destroy_all
puts "seeding sweet good music....."
puts "seeding users....."
puts "seeding offers....."
puts "seeding bookings...."
# the Le Wagon copy of the API
api = Discogs::Wrapper.new("Tokyo Vinyls", user_token: ENV["DISCOGS_TOKEN"])

artist_ids = [3852273, 65049]
search = api.search(artist_ids, :per_page => 10)

releases = search["results"]



releases.map do |release|
  release_data = api.get_release(release["id"])

  releases = search["results"]
  # itterate over each results to get its details using get_release

  composer = Artist.find_or_initialize_by(
          name: release_data["artists"].first["name"]
         )
  phonograph = Vinyl.new(
          name: release_data["title"],
          publishing_year: release_data["year"].to_i,
          img_url: release_data["images"][0]["uri"],
          genre: release_data["genres"].first,
          artist: composer
        )
  phonograph.artist = composer
  phonograph.save!
end

artist_ids.each do |artist_id|

  data2 = api.get_artist(artist_id)
  composer = Artist.find_by(name: data2["name"])
  if composer
    composer.update(
      profile: data2["profile"],
      profile_img: data2["images"][0]["uri"]
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

addresses_file = File.open('db/locations.yml').read
addresses = YAML.load(addresses_file)


User.all.each do |user|
  offer = Offer.new(
    price: [100, 200, 300].sample,
    user: user,
    description: Faker::Quotes::Shakespeare.hamlet_quote,
    vinyl: Vinyl.all.sample,
    condition: ["good", "bad", "ok"].sample,
    location: addresses.sample
  )
  offer.save!
end

User.all.each do |user|
  rand(1..6).times do
    Booking.create!(
      user: user,
      offer: Offer.where.not(id: user.offers).sample,
      start_date: Date.today + rand(5..10),
      end_date: Date.today + rand(11..15)
    )
  end
end


puts "finished seeding sweet good music"
puts "finished seeding users"
puts "finished seeding offers"
puts "finished seeding booking"


# search = wrapper.search("Elton John", :per_page => 10, :type => :artist)

# artist          = wrapper.get_artist("57103")
# artist_releases = wrapper.get_artist_releases("57103")
# release         = wrapper.get_release("1529724")
# label           = wrapper.get_label("29515")





# when searching with artist:
# image is called "cover_image"


# Artist_releases for image "thumb"

# images
# 57103


# img_url: release_data["images"].first["uri"],
#       genre: release_data["genres"].first,

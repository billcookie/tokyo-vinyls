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

artist_ids = [2508414, 65049, 304053, 3852273, 1615988, 2171152]

releases = artist_ids.map do |artist_id|
  search = api.search(artist_id, :per_page => 10)
  data = search["results"]
end

releases.each do |vinyls|



  vinyls.map do |release|
    release_data = api.get_release(release["id"])


    # itterate over each results to get its details using get_release

    composer = Artist.find_or_initialize_by(
            name: release_data["artists"] ? release_data["artists"].first["name"] : "Bob"
          )
    phonograph = Vinyl.new(
            name: release_data["title"] ? release_data["title"] : "Generic Title",
            publishing_year: release_data["year"] ? release_data["year"].to_i : 2022,
            img_url: release_data["images"] ? release_data["images"][0]["uri"] : "https://upload.wikimedia.org/wikipedia/commons/b/b1/Vinyl_record_LP_10inch.JPG",
            genre: release_data["genres"] ? release_data["genres"].first : "Rock 'n' Roll",
            artist: composer
            )
      phonograph.artist = composer
      phonograph.save!
  end
end
artist_ids.each do |artist_id|

  data2 = api.get_artist(artist_id)
  composer = Artist.find_by(name: data2["name"] ? data2["name"] : "Bob" )
  if composer
    composer.update(
      profile: data2["profile"] ? data2["profile"] : "Hello",
      profile_img: data2["images"] ? data2["images"][0]["uri"] : "https://cdn3.careeraddict.com/uploads/article/54483/medium-man-playing-acoustic-guitar.jpg"
    )
  end
end

16.times do
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
  first_name: "Bill",
  last_name: "Cook"
)

User.create!(
  email: "willmes.carla@gmail.com",
  password: "123123",
  first_name: "Carla",
  last_name: "Willmes"
)

User.create!(
  email: "ayakayakaaaa@gmail.com",
  password: "123123",
  first_name: "Ayaka",
  last_name: "Inaba"
)

User.create!(
  email: "jdchappelow@gmail.com",
  password: "123123",
  first_name: "Joshy",
  last_name: "Woshy"
)

addresses_file = File.open('db/locations.yml').read
addresses = YAML.load(addresses_file)


User.all.each do |user|
  rand(1..8).times do
    Offer.create!(
      price: [100, 200, 300].sample,
      user: user,
      description: Faker::Quotes::Shakespeare.hamlet_quote,
      vinyl: Vinyl.all.sample,
      condition: ["good", "bad", "ok"].sample,
      location: addresses.sample
    )
  end
end

User.all.each do |user|
  rand(1..5).times do
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

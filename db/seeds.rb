require "discogs"
puts "destroying sweet good music"
Vinyl.destroy_all
# List.destroy_all
puts "seeding sweet good music"
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


puts "finished seeding sweet good music"


# search = auth_wrapper.search("Necrovore", :per_page => 10, :type => :artist)

# artist          = wrapper.get_artist("329937")
# artist_releases = wrapper.get_artist_releases("329937")
# release         = wrapper.get_release("1529724")
# label           = wrapper.get_label("29515")

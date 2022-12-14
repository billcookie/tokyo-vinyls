class VinylsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :new, :create]
  skip_after_action :verify_authorized

  def index
    if params[:query].present?
      @vinyls = policy_scope(Vinyl.song_artist_search(params[:query]))
      @api_vinyls = api_results
    else
      @vinyls = policy_scope(Vinyl)
    end
  end

  def show
    @vinyl = Vinyl.find(params[:id])
    @offers = @vinyl.offers
    @offer = Offer.new
    @markers = @offers.geocoded.map do |offer|
      {
        lat: offer.latitude,
        lng: offer.longitude
      }
    end
  end


  def new
    @vinyl = Vinyl.new
    authorize @vinyl
  end

  def create
    @vinyl = Vinyl.new(vinyl_params)
    authorize @vinyl
    if @vinyl.save
      redirect_to vinyl_path(@vinyl)
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def vinyl_params
    params.require(:vinyl).permit(:name, :publishing_year, :genre, :artist_id, :img_url, artist_attributes: [:name])
  end

  def api_results
    api = Discogs::Wrapper.new("Tokyo Vinyls", user_token: ENV["DISCOGS_TOKEN"])
    search = api.search(params[:query], :per_page => 10)

    # when we search will have search results which will be releases
    releases = search["results"]
    # itterate over each results to get its details using get_release
    releases.map do |release|
      release_data = api.get_release(release["id"])
      # For each of these we need to build instances of a vinyl + artists
      artist = Artist.find_or_initialize_by(
        name: release_data["artists"] ? release_data["artists"].first["name"] : ["Lil Cookie", "$AyakaAyaka", "C-Dogu", "Joshy Woshy"].sample
      )
      Vinyl.new(
        name: release_data["title"] ? release_data["title"] : ["Carla's Adventure", "That Train a Coming In", "Washed Up", "Bootstrap"].sample,
        publishing_year: release_data["year"] ? release_data["year"].to_i : [2022, 1997, 1994, 1999, 1969, 1970].sample,
        img_url: release_data["images"] ? release_data["images"][0]["uri"] : ["https://upload.wikimedia.org/wikipedia/commons/b/b1/Vinyl_record_LP_10inch.JPG", "https://assets3.thrillist.com/v1/image/2747462/720x960/scale;webp=auto;jpeg_quality=60.jpg", "https://www.argospetinsurance.co.uk/assets/uploads/2014/06/Exotic-Short-Hair1.jpg"].sample,
        genre: release_data["genres"] ? release_data["genres"].first : ["Rock", "Blues", "RnB", "Soul", "Rap"].sample,
        artist: artist
      )
    end
  end
end

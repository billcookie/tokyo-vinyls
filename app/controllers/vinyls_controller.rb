class VinylsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  skip_after_action :verify_authorized
  def index
    @vinyls = policy_scope(Vinyl)
  end

  def show
    @vinyl = Vinyl.find(params[:id])
    @offers = @vinyl.offers
    @markers = @offers.geocoded.map do |offer|
      {
        lat: offer.latitude,
        lng: offer.longitude
      }
    end
  end
end

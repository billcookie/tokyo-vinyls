class OffersController < ApplicationController
  def index
    @offers = policy_scope(Offer)
    @markers = @offers.geocoded.map do |offer|
      {
        lat: offer.latitude,
        lng: offer.longitude,
        info_window: render_to_string(partial: "offers/popup", locals: { offer: offer }),
        # img_url: helpers.asset_url("REPLACE_THIS_WITH_YOUR_IMAGE_IN_ASSETS")
      }
    end
  end

  def show
    @offer = Offer.find(params[:id])
    @booking = Booking.new(offer: @offer)
    authorize @offer
  end

  def new
    @vinyl = Vinyl.find(params[:vinyl_id])
    @offer = Offer.new
    @offer.build_vinyl
    authorize @offer
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.user = current_user
    authorize @offer
    @vinyl = Vinyl.find(params[:vinyl_id])
    @offer.vinyl = @vinyl

    if @offer.save
      redirect_to bookings_path
      flash[:alert] = "New Offer Successfully Created"
    else
      render :new, status: :unprocessable_entity
    end
  end
  private

  def offer_params
    params.require(:offer).permit(:description, :price, :condition, :location)
  end
end

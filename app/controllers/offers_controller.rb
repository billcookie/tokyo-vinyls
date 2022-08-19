class OffersController < ApplicationController
  def index
    @offers = policy_scope(Offer)
    @markers = @offers.geocoded.map do |offer|
      {
        lat: offer.latitude,
        lng: offer.longitude,
        info_window: render_to_string(partial: "offers/popup", locals: { offer: offer })
      }
    end
  end

  def show
    @offer = Offer.find(params[:id])
    @booking = Booking.new(offer: @offer)
    authorize @offer
  end

  def new
    @offer = Offer.new
    @offer.build_vinyl
    authorize @offer
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.user = current_user
    authorize @offer
    if offer_params[:vinyl_id]
      @vinyl = Vinyl.find(offer_params[:vinyl_id])
      @offer.vinyl = @vinyl
    end
    if @offer.save
      redirect_to offers_path
      flash[:alert] = "New Offer Successfully Created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # def price_calc
  #   start = Date.parse(params[:startDate])
  #   end_date = Date.parse(params[:endDate])
  #   price = @vehicle.cost * (end - start).to_i
  # end

  private

  def offer_params
    params.require(:offer).permit(:vinyl_id, :description, :price, :condition, :location)
  end
end

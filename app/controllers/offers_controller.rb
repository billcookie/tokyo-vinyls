class OffersController < ApplicationController
  def index
    @offers = policy_scope(Offer)
  end

  def show
    @offer = Offer.find(params[:id])
    authorize @offer
  end

  def new
    @offer = Offer.new
    authorize @offer
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.user = current_user
    authorize @offer
    @vinyl = Vinyl.find(offer_params[:vinyl_id])
    @offer.vinyl = @vinyl
    if @offer.save
      redirect_to offers_path

    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def offer_params
    params.require(:offer).permit(:vinyl_id, :description, :price, :condition, :location)
  end
end

class OffersController < ApplicationController

  def show
    @offer = Offer.find(params[:id])
  end

  def index
    @offers = Offer.all
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new
    @offer.user = current_user
    @vinyl = Offer.vinyl
    if @offer.save
      redirect_to offers_path

    else
      render :new, status: :unprocessable_entiy
    end
  end


  private

  def offer_params
    params.require(:offer).permit(:vinyl_id, :description, :price, :condition, :location)
  end
end

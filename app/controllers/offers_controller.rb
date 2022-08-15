class OffersController < ApplicationController

  def show
    @offer = Offer.find(params[:id])
  end

  def index
    @offers = Offer.all
  end

end

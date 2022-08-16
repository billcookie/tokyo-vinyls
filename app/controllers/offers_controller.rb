class OffersController < ApplicationController

  def show
    @offer = Offer.find(params[:id])
  end

  def index
    @booking = Booking.new
    @offer = Offer.new
    @offers = Offer.all
  end

end

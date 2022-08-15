class OffersController < ApplicationController
  def index
    @offers = Offer.all
  end
end

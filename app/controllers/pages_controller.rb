class PagesController < ApplicationController
  def home
    @offers = Offer.where(price: 100)
  end
end

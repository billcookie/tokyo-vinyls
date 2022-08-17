class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  def home
    @offers = Offer.where(price: 100)
  end
end

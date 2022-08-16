class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
    authorize @bookings
  end

  def show
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    authorize @booking
    @offer = Offer.find(booking_params[:offer_id])
    @booking.offer = @offer
    if @offer.save
      redirect_to bookings_path
    else
      render :new, status: :unprocessable_entity
    end
  end


  private

  def booking_params
    params.require(:booking).permit(:offer_id, :start_date, :end_date, :status)
  end
end

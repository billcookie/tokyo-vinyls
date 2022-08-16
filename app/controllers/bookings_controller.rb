class BookingsController < ApplicationController
  def index
    @bookings = policy_scope(Booking)
  end

  def show
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def create

    @booking = Booking.new(booking_params)
    @booking.user = current_user
    authorize @booking

    @offer = Offer.find(params[:offer_id])

    @booking.offer = @offer

    if @booking.save
      redirect_to offer_bookings_path(@offer)
    else
      render :new, status: :unprocessable_entity
    end
  end


  private

  def booking_params
    params.require(:booking).permit(:offer_id, :start_date, :end_date, :status)
  end
end

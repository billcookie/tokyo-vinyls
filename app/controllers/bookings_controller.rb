class BookingsController < ActionController::Base

  def index

    @bookings = Booking.all
  end


  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :new, status: :unprocessable_entity
    end
  end

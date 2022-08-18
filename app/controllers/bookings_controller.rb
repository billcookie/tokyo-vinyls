class BookingsController < ApplicationController
  def index
    @bookings = policy_scope(Booking)
    @bookings_as_owner = current_user.bookings_as_owner
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
      redirect_to bookings_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @booking = Booking.find(params[:id])
    authorize @booking
    if @booking.update(booking_params)
      redirect_to bookings_path
    else
      @bookings = policy_scope(Booking)
      @bookings_as_owner = current_user.bookings_as_owner
      render :index
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.destroy
    redirect_to bookings_path, status: :see_other
  end

  private

  def booking_params
    params.require(:booking).permit(:offer_id, :start_date, :end_date, :status)
  end
end

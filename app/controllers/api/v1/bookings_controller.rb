class Api::V1::BookingsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update]
  # before_action :set_booking, only: [:show, :edit, :update, :destroy]

  respond_to :json

  def index
    respond_with current_user.bookings
  end

  def show
    respond_with current_user.bookings.find(params[:id])
  end

  def create
    booking = current_user.bookings.build(booking_params)
    if booking.save
      render json: booking, status: 201, location: [:api, current_user, booking]
    else
      render json: { errors: booking.errors }, status: 422
    end
  end

  def update
    booking = current_user.bookings.find(params[:id])
    if booking.update(booking_params)
      render json: booking, status: 200, location: [:api, booking]
    else
      render json: { errors: booking.errors }, status: 422
    end
  end

  def destroy
    booking = current_user.bookings.find(params[:id])
    booking.destroy
    head 204
  end

  private

    def booking_params
      params.require(:booking).permit(:offer_id, :quantity, :amount, :user_id, :paid, :paid_on)
    end
  end

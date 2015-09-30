class Api::V1::BookingsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update, :destroy]
  # before_action :set_booking, only: [:show, :edit, :update, :destroy]

  respond_to :json

  api :GET, '/bookings', "Show all bookings"
  def index
    bookings = params[:booking_ids].present? ? Booking.find(params[:booking_ids]) : Booking.all
    respond_with bookings
  end

  api :GET, '/bookings/:id', "Show a single booking"
  def show
    respond_with Booking.find(params[:id])

  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'No such booking exist' }, status: 422
  end

  api :POST, '/bookings', "Create a booking"
  param :booking, Hash, desc: "Booking Information" do
    param :offer_id, :number, desc: "Offer ID", required: true
    param :quantity, :number, desc: 'Quantity', required: true
    param :amount, :number, desc: 'Amount', required: true
  end
  def create
    booking = current_user.bookings.build(booking_params)
    if booking.save
      render json: booking, status: 201, location: [:api, booking]
    else
      render json: { errors: booking.errors }, status: 422
    end
  end

  api :PUT, '/bookings/:id', "Update a booking"
  param :booking, Hash, desc: "Booking Information" do
    param :offer_id, :number, desc: "Offer ID", required: true
    param :quantity, :number, desc: 'Quantity'
    param :amount, :number, desc: 'Amount'
    param :paid, :bool, decs: 'Payment status, default: false'
    param :paid_on, DateTime, desc: 'Payment date'
  end
  def update
    booking = current_user.bookings.find(params[:id])
    if booking.update(booking_params)
      render json: booking, status: 200, location: [:api, booking]
    else
      render json: { errors: booking.errors }, status: 422
    end

  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'No such booking exist' }, status: 422
  end

  api :DELETE, '/bookings/:id', "Delete a booking"
  def destroy
    booking = Booking.find(params[:id])
    booking.destroy
    head 204

  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'No such booking exist' }, status: 422
  end

  private

    def booking_params
      params.require(:booking).permit(:offer_id, :quantity, :amount, :user_id, :paid, :paid_on)
    end
  end

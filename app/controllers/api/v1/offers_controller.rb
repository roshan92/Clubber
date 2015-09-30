class Api::V1::OffersController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update, :destroy]
  # before_action :set_offer, only: [:show, :edit, :update, :destroy]

  respond_to :json

  api :GET, '/offers', "Shows all offers"
  def index
    offers = params[:offer_ids].present? ? Offer.find(params[:offer_ids]) : Offer.all
    respond_with offers
    # respond_with Offer.search(params)
  end

  api :GET, '/offers/:id', "Show a single offer"
  def show
    respond_with Offer.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'No such offer exist' }, status: 422
  end

  api :POST, '/offers', "Create an offer"
  param :offer, Hash, desc: "Offer Information" do
    param :item_id, Integer, desc: "Item ID", required: true
    param :price, Float, desc: 'Price', required: true
    param :quantity, Integer, desc: 'Quantity', required: true
    param :deal_open_hour, DateTime, desc: 'Deal open hour', required: true
    param :deal_closed_hour, DateTime, desc: 'Deal closed hour', required: true
  end
  def create
    offer = current_user.offers.build(offer_params)
    if offer.save
      render json: offer, status: 201, location: [:api, offer]
    else
      render json: { errors: offer.errors }, status: 422
    end
  end

  api :PUT, '/offers/:id', "Update an offer"
  param :offer, Hash, desc: "Offer Information" do
    param :item_id, :number, desc: "Item ID", required: true
    param :price, :number, desc: 'Price'
    param :quantity, :number, desc: 'Quantity'
    param :deal_open_hour, DateTime, desc: 'Deal open hour'
    param :deal_closed_hour, DateTime, desc: 'Deal closed hour'
    param :status, :bool, desc: 'Offer status, default: true'
    param :payment, :bool, desc: 'Payment status, default: false'
  end
  def update
    offer = current_user.offers.find(params[:id])
    if offer.update(offer_params)
      render json: offer, status: 200, location: [:api, offer]
    else
      render json: { errors: offer.errors }, status: 422
    end

  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'No such offer exist' }, status: 422
  end

  api :DELETE, '/offers/:id', "Delete an offer"
  def destroy
    offer = Offer.find(params[:id])
    offer.destroy
    head 204

  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'No such offer exist' }, status: 422
  end

  private

    def offer_params
      params.require(:offer).permit(:item_id, :user_id, :status, :price, :payment, :quantity, :deal_open_hour, :deal_closed_hour )
    end
  end

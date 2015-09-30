class Api::V1::ItemsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update]
  # before_action :set_item, only: [:show, :edit, :update, :destroy]

  respond_to :json

  def index
    items = params[:item_ids].present? ? item.find(params[:item_ids]) : item.all
    respond_with items

    # respond_with item.search(params)
  end

  def show
    respond_with item.find(params[:id])
  end

  def create
    item = current_user.items.build(item_params)
    if item.save
      render json: item, status: 201, location: [:api, item]
    else
      render json: { errors: item.errors }, status: 422
    end
  end

  def update
    item = current_user.items.find(params[:id])
    if item.update(item_params)
      render json: item, status: 200, location: [:api, item]
    else
      render json: { errors: item.errors }, status: 422
    end
  end

  def destroy
    item = current_user.items.find(params[:id])
    item.destroy
    head 204
  end

  private

    def item_params
      params.require(:item).permit(:name, :description, :price, :user_id )
    end
  end

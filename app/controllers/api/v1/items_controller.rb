class Api::V1::ItemsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update, :destroy]
  # before_action :set_item, only: [:show, :edit, :update, :destroy]

  respond_to :json

  api :GET, '/items', "Shows all items"
  def index
    items = params[:item_ids].present? ? item.find(params[:item_ids]) : Item.all
    respond_with items
  end

  api :GET, '/items/:id', "Show a single item"
  def show
    respond_with Item.find(params[:id])

  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'No such item exist' }, status: 422
  end

  api :POST, '/items', "Create an item"
  param :item, Hash, desc: "Item Information" do
    param :name, String, desc: "Name", required: true
    param :description, String, desc: 'Description', required: true
    param :price, String, desc: 'Price', required: true
  end
  def create
    item = current_user.items.build(item_params)
    if item.save
      render json: item, status: 201, location: [:api, item]
    else
      render json: { errors: item.errors }, status: 422
    end
  end

  api :PUT, '/items/:id', "Update an item"
  param :item, Hash, desc: "Item Information" do
    param :name, String, desc: "Name"
    param :description, String, desc: 'Description'
    param :price, String, desc: 'Price'
  end
  def update
    item = current_user.items.find(params[:id])
    if item.update(item_params)
      render json: item, status: 200, location: [:api, item]
    else
      render json: { errors: item.errors }, status: 422
    end

  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'No such item exist' }, status: 422
  end

  api :DELETE, '/items/:id', "Delete an item"
  def destroy
    item = Item.find(params[:id])
    item.destroy
    head 204

  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'No such item exist' }, status: 422
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :user_id )
  end
end

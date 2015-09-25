class Api::V1::OffersController < ApplicationController
  before_action :authenticate_with_token!, except: [:index_all]
  before_action :set_offer, only: [:show, :edit, :update, :destroy]

  def index
    if user_signed_in?
      if current_user.is_admin?
        @offers = Offer.all

        respond_to do |format|
          format.html
          format.json { render json: @offers }
        end
      else
        @offers = current_user.offers

        respond_to do |format|
          format.html
          format.json { render json: @offers }
        end
      end
    else
      render json: {}, status: :unauthorized
    end
  end

  def index_all
    @offers = Offer.all

    respond_to do |format|
      format.html
      format.json { render json: @offers }
    end
  end

  def show
    if current_user.is_owner?(@offer) || current_user.is_admin?
      respond_to do |format|
        format.html { render :show }
        format.json { render json: @offer}
      end
    else
      respond_to do |format|
        format.html { render :show, notice: 'You are not allowed to view this.' }
        format.json { render json: {}, status: :unauthorized}
      end
    end
  end

  def new
    @offer = Offer.new

    if current_user.is_admin?
      @item = Item.all
    else
      @item = Item.where(user_id: current_user.id)
    end
  end

  def edit
    if current_user.is_admin?
      @item = Item.all
    else
      @item = Item.where(user_id: current_user.id)
    end
  end

  def create
    @offer = current_user.offers.new(offer_params)

    respond_to do |format|
      if @offer.save
        format.html { redirect_to @offer, notice: 'Offer was successfully created.' }
        format.json { render :show, status: :created, location: @offer }
      else
        format.html { render :new }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if current_user.is_owner?( @offer ) || current_user.is_admin?
      respond_to do |format|
        if @offer.update(offer_params)
          format.html { redirect_to @offer, notice: 'Offer was successfully updated.' }
          format.json { render :show, status: :ok, location: @offer }
        else
          format.html { render :edit }
          format.json { render json: @offer.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @offer.destroy
    respond_to do |format|
      format.html { redirect_to offers_url, notice: 'Offer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_offer
      @offer = Offer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offer_params
      params.require(:offer).permit(:item_id, :user_id, :status, :price, :quantity, :deal_open_hour, :deal_closed_hour )
    end
end

class Api::V1::EventsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update]
  # before_action :set_event, only: [:show, :edit, :update, :destroy]

  respond_to :json

  def index
    events = params[:event_ids].present? ? event.find(params[:event_ids]) : event.all
    respond_with events

    # respond_with event.search(params)
  end

  def show
    respond_with event.find(params[:id])
  end

  def create
    event = current_user.events.build(event_params)
    if event.save
      render json: event, status: 201, location: [:api, event]
    else
      render json: { errors: event.errors }, status: 422
    end
  end

  def update
    event = current_user.events.find(params[:id])
    if event.update(event_params)
      render json: event, status: 200, location: [:api, event]
    else
      render json: { errors: event.errors }, status: 422
    end
  end

  def destroy
    event = current_user.events.find(params[:id])
    event.destroy
    head 204
  end

  private

    def event_params
      params.require(:event).permit(:user_id, :event_name, :event_description, :event_date, :event_time)
    end
  end

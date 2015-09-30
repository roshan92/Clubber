class Api::V1::EventsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update, :destroy]
  # before_action :set_event, only: [:show, :edit, :update, :destroy]

  respond_to :json

  api :GET, '/events', "Show all events"
  def index
    events = params[:event_ids].present? ? Event.find(params[:event_ids]) : Event.all
    respond_with events
    # respond_with event.search(params)
  end

  api :GET, '/events/:id', "Show a single event"
  def show
    respond_with Event.find(params[:id])

  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'No such event exist' }, status: 422
  end

  api :POST, '/events', "Create an event"
	param :event, Hash, desc: "Event Information" do
		param :event_name, String, desc: "Name", required: true
		param :event_description, String, desc: 'Description', required: true
    param :event_date, Date, desc: 'Date', required: true
    param :event_time, Time, desc: 'Time', required: true
	end
  def create
    event = current_user.events.build(event_params)
    if event.save
      render json: event, status: 201, location: [:api, event]
    else
      render json: { errors: event.errors }, status: 422
    end
  end

  api :PUT, '/events/:id', "Update an event"
	param :event, Hash, desc: "Event Information" do
		param :event_name, String, desc: "Name"
		param :event_description, String, desc: 'Description'
    param :event_date, Date, desc: 'Date'
    param :event_time, Time, desc: 'Time'
	end
  def update
    event = current_user.events.find(params[:id])
    if event.update(event_params)
      render json: event, status: 200, location: [:api, event]
    else
      render json: { errors: event.errors }, status: 422
    end
  rescue ActiveRecord::RecordNotFound
		render json: { errors: 'No such event exist' }, status: 422
  end

  api :DELETE, '/events/:id', "Delete an event"
  def destroy
    event = Event.find(params[:id])
    event.destroy
    head 204

  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'No such event exist' }, status: 422
  end

  private

    def event_params
      params.require(:event).permit(:user_id, :event_name, :event_description, :event_date, :event_time)
    end
  end

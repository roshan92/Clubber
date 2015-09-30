class Api::V1::InvitesController < ApplicationController
	before_action :authenticate_with_token!, only: [:create, :update, :destroy]

	respond_to :json

	api :GET, '/invites', "Shows all invites"
  def index
    invites = params[:invite_ids].present? ? Invite.find(params[:invite_ids]) : Invite.all
    respond_with invites
    # respond_with event.search(params)
  end

	api :GET, '/invites/:id', "Show a single invite"
  def show
    respond_with Invite.find(params[:id])

	rescue ActiveRecord::RecordNotFound
		render json: { errors: 'No such invite exist' }, status: 422
  end

	api :POST, '/invites', "Create an invite"
	param :invite, Hash, desc: "Invite Information" do
		param :attended_event_id, :number, desc: "Attended Event ID", required: true
		param :guest_id, :number, desc: 'Guest ID', required: true
	end
  def create
    invite = current_user.invites.build(invite_params)
    if invite.save
      render json: invite, status: 201, location: [:api, invite]
    else
      render json: { errors: invite.errors }, status: 422
    end
  end

	api :PUT, '/invites/:id', "Update an invite"
	param :invite, Hash, desc: "Invite Information" do
		param :attended_event_id, :number, desc: "Attended Event ID", required: true
		param :guest_id, :number, desc: 'Guest ID', required: true
	end
  def update
    invite = current_user.invites.find(params[:id])
    if invite.update(invite_params)
      render json: event, status: 200, location: [:api, invite]
    else
      render json: { errors: invite.errors }, status: 422
    end

	rescue ActiveRecord::RecordNotFound
		render json: { errors: 'No such invite exist' }, status: 422
  end

	api :DELETE, '/invites/:id', "Delete an invite"
  def destroy
		invite = Invite.find(params[:id])
    invite.destroy
    head 204

  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'No such invite exist' }, status: 422
  end

  private

  def invite_params
    params.require(:invite).permit(:attended_event_id, :guest_id)
  end
end

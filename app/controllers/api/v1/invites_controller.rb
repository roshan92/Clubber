class Api::V1::InvitesController < ApplicationController
	before_action :authenticate_with_token!, only: [:create, :update]

	respond_to :json

  def index
    invites = params[:invite_ids].present? ? invite.find(params[:invite_ids]) : invite.all
    respond_with invites

    # respond_with event.search(params)
  end

  def show
    respond_with invite.find(params[:id])
  end

  def create
    invite = current_user.invites.build(invite_params)
    if invite.save
      render json: invite, status: 201, location: [:api, invite]
    else
      render json: { errors: invite.errors }, status: 422
    end
  end

  def update
    invite = current_user.invites.find(params[:id])
    if invite.update(invite_params)
      render json: event, status: 200, location: [:api, invite]
    else
      render json: { errors: invite.errors }, status: 422
    end
  end

  def destroy
    invite = current_user.invites.find(params[:id])
    invite.destroy
    head 204
  end

  private

  def invite_params
    params.require(:invite).permit(:attended_event_id, :guest_id)
  end
end

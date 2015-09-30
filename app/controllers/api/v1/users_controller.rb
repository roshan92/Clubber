class Api::V1::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: [:update, :destroy]
  respond_to :json

  api :GET, '/users', "Show all registered users"
  def index
    respond_with User.all
  end

  api :GET, '/users/:id', "Show an user details"
  def show
    respond_with  User.find(params[:id])
  end

  api :POST, '/users', "Create an user"
  param :user, Hash, desc: "User Information" do
    param :email, String, desc: "Email", required: true
    param :password, String, desc: 'Password', required: true
    param :password_confirmation, String, desc: 'Password confirmation', required: true
    param :first_name, String, desc: 'First name', required: true
    param :last_name, String, desc: 'Last name', required: true
    param :type, ["Guest","Manager","Admin","Organizer","VIP"], desc: "User type", required: true
  end
  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  api :PUT, '/users/:id', "Update an user"
  param :user, Hash, desc: "User Information" do
    param :email, String, desc: "Email"
    param :password, String, desc: 'Password'
    param :password_confirmation, String, desc: 'Password confirmation'
    param :first_name, String, desc: 'First name'
    param :last_name, String, desc: 'Last name'
    param :type, ["Guest","Manager","Admin","Organizer","VIP"], desc: "User type"
  end
  def update
    user = current_user

    if user.update(user_params)
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  api :DELETE, '/users/:id', "Delete an user"
  def destroy
    current_user.destroy
    head 204
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :type, :deleted_at)
  end
end

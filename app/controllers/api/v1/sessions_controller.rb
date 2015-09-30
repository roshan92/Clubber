class Api::V1::SessionsController < ApplicationController
  respond_to :json

  api :POST, '/sessions', "User login"
  param :session, Hash, desc: "Login credentials" do
    param :email, String, desc: "Email", required: true
    param :password, String, desc: 'Password', required: true
  end
  def create
    user_password = params[:session][:password]
    user_email = params[:session][:email]
    user = user_email.present? && User.find_by(email: user_email)

    if user.valid_password? user_password
      sign_in user, store: false
      user.generate_authentication_token!
      user.save
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end

  api :DELETE, '/sessions/:id', "User sign out"
  def destroy
    destroy_user_session
    head 204
  end

  private

  def destroy_user_session
    user = User.find(params[:id])
    user.update(auth_token: nil)
  end
end

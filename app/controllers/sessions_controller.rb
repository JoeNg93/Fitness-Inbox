class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def login
    @user = Client.find_by(email: params[:client][:email].downcase)
    if @user && @user.authenticate(params[:client][:password])
      cookies.permanent.signed[:user_id] = @user.id
      render json: @user
    else
      render json: { error: 'Wrong email or password' }, status: 401
    end
  end

  def logout
    if cookies.signed[:user_id]
      cookies.delete(:user_id)
      render json: {}, status: 200
    else
      render json: { error: "You're not logged in" }, status: 401
    end
  end

  def authenticate
    if cookies.signed[:user_id]
      client = Client.find(cookies.signed[:user_id])
      if client
        render json: client and return
      end
    end
    render json: { error: 'Not authenticate using cookies' }, status: 401
  end

end

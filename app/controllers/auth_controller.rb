class AuthController < ApplicationController
  def create
    user = User.authenticate(auth_params[:email], auth_params[:password])

    if user
      payload = { user_id: user.id, exp: 4.days.from_now.to_i }
      token = JWT.encode(payload, Rails.application.credentials.secret_key_base, 'HS256')

      render json: { token: token }
    else
      error_response([{ auth: 'Invalid email or password' }])
    end
  end

  def auth_params
    params.require(:user).permit(:email, :password)
  end
end

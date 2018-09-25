class ApplicationController < ActionController::API


  def authenticate
    user = User.load_by_token(request.headers['Authorization'])
    if user
      @current_user = user
    else
      error_response([{ token: 'is invalid or expired' }])
    end
  end

  def error_response(errors)
    render json: { errors: errors }, status: :unprocessable_entity
  end

  def current_user
    @current_user
  end
end

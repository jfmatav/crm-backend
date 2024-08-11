class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(payload)
    JWT.encode(payload, ENV.fetch('PASSWORD_KEY', nil))
  end

  def decoded_token
    header = request.headers['Authorization']
    if header
      token = header.split(" ")[1]
      begin
        JWT.decode(token, ENV.fetch('PASSWORD_KEY', nil))
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def authenticate_admin
    unless !!current_user and current_user.admin?
      render json: { message: 'User not authorized to perform this action' }, status: :unauthorized
    end
  end

  def current_user 
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @current_user = User.find_by(id: user_id)
    end
  end

  def authorized
    unless !!current_user
      render json: { message: 'Please log in' }, status: :unauthorized
    end
  end
end

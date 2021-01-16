# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(payload)
    JWT.encode payload, 'thisissecret'
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, 'thisissecret', true, algorithm: 'HS256')
      rescue StandardError => e
        nil
      end
    end
  end

  def logged_in_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    return if logged_in?

    render json: { message: 'Please login' }, status: :unauthorized
  end
end

class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      json_response({errors: e.message}, :unauthorised)
    rescue JWT::DecodeError => e
      json_response({errors: e.message}, :unauthorised)
    end
  end
end

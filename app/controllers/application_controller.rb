class ApplicationController < ActionController::API

  attr_reader :current_user

  def authorize
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
      render_error(:unauthorized, e)
    end
  end

  ##
  # Render a json error message from exception message and the HTTP status code defined by
  # the status parameter. The json result structure fulfill standard [jsonapi.org](jsonapi.org).
  #
  # @param exception [StandardError] Exception captured with message text.
  # @param status [Symbol] The HTTP status response code symbol.
  # @param active_model_errors [ActiveModel::Errors] Optionally, error received from Active Model.
  #   Used for <tt>ActiveModel::Errors.full_messages()</tt>.
  #
  def render_error(status, exception, active_model_errors = nil)
    correlation_id = SecureRandom.uuid
    errors = []
    errors = errors_to_hash(correlation_id, active_model_errors, status) if active_model_errors
    errors.push(exception_to_hash(correlation_id, exception, status)) if exception
    render json: { 'errors': errors }, status: status
  end

  ##
  # Common handling of <tt>ActionController::ParameterMissing</tt> in passed block.
  #
  # @param [&block]
  #
  def protect_parameter_missing
    yield
  rescue ActionController::ParameterMissing => e
    render_error(:bad_request, e)
  end

  private

  ##
  # As defined in https://jsonapi.org/format/#error-objects
  #
  # @param [String] id
  # @param [String] title
  # @param [String] detail
  # @param [String] status
  def json_error(id, title, detail, status)
    { 'id': id, 'title': title, 'detail': detail, 'status': status }
  end

  ##
  # Convert Exception object to a jsonapi standard hash
  #
  # @param [string] id
  # @param [Exception] exception
  # @param [Symbol] status Symbols matching the HTTP response status codes.
  def exception_to_hash(id, exception, status)
    json_error(id, exception.class.name, exception.message, status)
  end

  ##
  # Convert an <tt>ActiveModel::Errors</tt> objects in a json-api standard hash using
  # <tt>full_messages()</tt> method.
  #
  # @param id [string] To pass as <tt>id</tt> to <tt>json_error()</tt>.
  # @param active_model_errors [ActiveModel::Errors]
  # @param status [string] To pass as <tt>status</tt> to <tt>json_error()</tt>.
  #
  def errors_to_hash(id, active_model_errors, status)
    errors = []
    active_model_errors.full_messages.each do |error_message|
      errors.push(json_error(id, active_model_errors.class.name, error_message, status))
    end
    errors
  end
end

class ApplicationController < ActionController::API
  before_action :authenticate_request

  def health
    if db_health_check
      render json: {app_check: "success", db_check: "success"}, status: :ok
    else
      render json: {app_check: "success", db_check: "failure"}, status: :bad_request
    end
  end


  private


  def render_service(service)
    if service.perform
      render json: service.result, status: :ok
    else
      render_error_status(service.error_status || 400, service.errors.full_messages, service.error_code)
    end
  rescue
    reder json: "Internal Server Error", status: :internal_server_error
  end

  def authenticate_request
    render_403 if  request.headers['X-API-KEY'] && request.headers['X-API-KEY'] != ENV['API_KEY']

    true
  end

  def db_health_check
    ActiveRecord::Base.connection.query("SELECT 1").present?
  rescue StandardError
    false
  end

  def render_404(error_message="Not found")
    render_error_status(404, error_message)
  end

  def render_400(error_message="Bad request")
    render_error_status(400, error_message)
  end

  def render_401(error_message="Unauthorized")
    render_error_status(401, error_message)
  end

  def render_403(error_message="Forbidden")
    render_error_status(403, error_message)
  end

  def render_500(error_message="Something went wrong")
    render_error_status(500, error_message)
  end

  def render_503(error_message="Service Unavailable")
    render_error_status(503, error_message)
  end

  def render_error_status(status, error_message, status_text=nil)
    status_string = status_text || (status == 400 ? "INVALID" : status)
    code = status_string.to_s.starts_with?("E_") ? status_string : "E_#{status_string}"
    render json: {code: code, error: error_message, errors: {base: [error_message]}}, status: status
  end
end

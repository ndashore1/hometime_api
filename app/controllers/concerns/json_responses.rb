# frozen_string_literal: true

module JsonResponses
  extend ActiveSupport::Concern

  private

  def render_data(message, data = {})
    render_response(message, :ok, data)
  end

  def render_error_response(message, data = {})
    render_response(message, :unprocessable_entity, data)
  end

  def render_success_response(message, data = {})
    render_response(message, :created, data)
  end

  def render_bad_request_response(message)
    render_response(message, :bad_request)
  end

  def render_response(message, code, data = {})
    render json: { message: message, data: data }, status: code
  end
end

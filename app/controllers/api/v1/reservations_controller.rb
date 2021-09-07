class Api::V1::ReservationsController < ApplicationController
  before_action :render_bad_request

  def create
    reservation = parse_reservation_payload
    message = response_message(reservation)

    if reservation.save
      render_data(message, reservation: reservation)
    else
      render_error_response(message)
    end
  end

  private

  def render_bad_request
    return if payload_valid?

    render_bad_request_response I18n.t('reservation.invalid')
  end

  def payload_valid?
    params.key?(:guest) || params[:reservation]&.key?(:guest_details)
  end

  def parse_reservation_payload
    reservation_attributes = ReservationPayload.call(params)
    reservation = find_or_build_reservation(reservation_attributes[:code])
    reservation.assign_attributes(reservation_attributes)
    reservation
  end

  def response_message(reservation)
    return reservation.errors.full_messages.to_sentence if reservation.invalid?

    reservation.persisted? ? I18n.t('reservation.updated') : I18n.t('reservation.successfully')
  end

  def find_or_build_reservation(code)
    Reservation.find_or_initialize_by(code: code)
  end
end

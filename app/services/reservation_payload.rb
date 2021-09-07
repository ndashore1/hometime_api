require_relative 'payloads/air_bnb'
require_relative 'payloads/booking'

class ReservationPayload < ApplicationService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    if params[:guest]
      AirBnb.call(params)
    else
      Booking.call(params[:reservation])
    end
  end
end

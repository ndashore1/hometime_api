class AirBnb < ApplicationService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    reservation
      .merge(reservation_guest_counts)
      .merge(reservation_prices)
      .merge(guest_attributes: guest_details)
  end

  private

  def reservation
    {
      code: params[:reservation_code],
      start_date: params[:start_date],
      end_date: params[:end_date],
      status: params[:status],
      currency: params[:currency]
    }
  end

  def reservation_guest_counts
    {
      nights: params[:nights],
      guests: params[:guests],
      adults: params[:adults],
      children: params[:children],
      infants: params[:infants]
    }
  end

  def reservation_prices
    {
      payout_price: params[:payout_price],
      security_price: params[:security_price],
      total_price: params[:total_price]
    }
  end

  def guest_details
    guest = params[:guest]
    return {} if guest.blank?

    {
      first_name: guest[:first_name],
      last_name: guest[:last_name],
      phone: guest[:phone],
      email: guest[:email]
    }
  end
end

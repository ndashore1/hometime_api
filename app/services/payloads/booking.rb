class Booking < ApplicationService
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
      code: params[:code],
      start_date: params[:start_date],
      end_date: params[:end_date],
      currency: params[:host_currency],
      status: params[:status_type]
    }
  end

  def reservation_guest_counts
    details = { guests: params[:number_of_guests], nights: params[:nights] }
    guest_details = params[:guest_details]
    return details if guest_details.blank?

    details.merge(
      adults: guest_details[:number_of_adults],
      children: guest_details[:number_of_children],
      infants: guest_details[:number_of_infants],
      localized_description: guest_details[:localized_description]
    )
  end

  def reservation_prices
    {
      payout_price: params[:expected_payout_amount],
      security_price: params[:listing_security_price_accurate],
      total_price: params[:total_paid_amount_accurate]
    }
  end

  def guest_details
    {
      email: params[:guest_email],
      first_name: params[:guest_first_name],
      last_name: params[:guest_last_name],
      phone: guest_numbers
    }
  end

  def guest_numbers
    return if params[:guest_phone_numbers].blank?

    params[:guest_phone_numbers].join(',')
  end
end

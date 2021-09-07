require 'rails_helper'
require './app/services/payloads/booking'

describe Booking do
  let(:reservation_attributes) do
    {
      code: 'YYY123452222',
      start_date: '2021-04-14',
      end_date: '2021-04-18',
      status: 'accepted',
      currency: 'AUD',
      nights: 4,
      guests: 4,
      adults: 2,
      children: 2,
      infants: 0,
      localized_description: '4 guests',
      payout_price: '4200.00',
      security_price: '500.00',
      total_price: '4700.00',
      guest_attributes: {
        first_name: 'Wayne',
        last_name: 'Woodbridge',
        phone: '639123456789,639123456789',
        email: 'wayne_woodbridge@bnb.com'
      }
    }
  end

  describe '#call' do
    context 'when params are valid' do
      it 'should return valid reservation attributes' do
        params = JSON.parse(file_fixture('payloads/booking.json').read, symbolize_names: true)
        expect(described_class.call(params[:reservation])).to eq(reservation_attributes)
      end
    end
  end
end

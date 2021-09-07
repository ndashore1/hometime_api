require 'rails_helper'

describe Api::V1::ReservationsController, type: :controller do
  let(:guest) { create(:guest, email: 'wayne_woodbridge@bnb.com') }
  let(:reservation) { create(:reservation, guest: guest) }
  let(:airbnb_params) do
    JSON.parse(file_fixture('payloads/air_bnb.json').read, symbolize_names: true)
  end
  let(:booking_params) do
    JSON.parse(file_fixture('payloads/booking.json').read, symbolize_names: true)
  end

  describe '#create' do
    shared_context 'create_reservation_successfully' do
      context 'when reservation code is unique' do
        before { post :create, params: json_params }

        it 'should create new reservation' do
          expect(Reservation.count).to eq(1)
          message = JSON.parse(response.body)['message']
          expect(message).to match('Reservation created successfully')
        end
      end
    end

    shared_context 'invalid_payload' do
      context 'when payload is invalid' do
        before do
          post :create, params: { "reservation": { "guest_email": 'test.wayne_woodbridge@bnb.com' } }
        end

        it 'should return error' do
          error_message = JSON.parse(response.body)['message']
          expect(error_message).to match('Payload is invalid')
        end
      end
    end

    shared_examples 'update_reservation_successfully' do
      it 'should update reservation update message' do
        message = JSON.parse(response.body)['message']
        expect(message).to match('Reservation updated successfully')
      end
    end

    shared_examples 'duplicate_guest_email' do
      it 'should return guest email not uniq error' do
        error_message = JSON.parse(response.body)['message']
        expect(error_message).to match('Guest email has already been taken')
      end
    end

    shared_examples 'invalid_status_code' do
      it 'should return invalid status message' do
        message = JSON.parse(response.body)['message']
        expect(message).to match('Status is invalid')
      end
    end

    context 'when reservation payload type is AirBnb' do
      context 'Success' do
        include_context 'create_reservation_successfully' do
          let(:json_params) { airbnb_params }
        end

        context 'when reservation code is not unique' do
          before do
            reservation
            params = json_params
            params[:reservation_code] = 'YYY12345111'
            post :create, params: params
          end

          it_behaves_like 'update_reservation_successfully'
        end
      end

      context 'Failure' do
        include_context 'invalid_payload'

        context 'when guest user email is not uniq' do
          before do
            reservation
            params = airbnb_params
            params[:email] = 'wayne_woodbridge@bnb.com'
            post :create, params: params
          end

          it_behaves_like 'duplicate_guest_email'
        end

        context 'when status is invalid' do
          before do
            params = airbnb_params
            params[:status] = 'rejected'
            post :create, params: params
          end

          it_behaves_like 'invalid_status_code'
        end
      end
    end

    context 'when reservation payload type is booking' do
      context 'Success' do
        include_context 'create_reservation_successfully' do
          let(:json_params) { booking_params }
        end

        context 'when reservation code is not unique' do
          before do
            reservation
            params = booking_params
            params[:reservation][:code] = 'YYY12345111'
            post :create, params: params
          end

          it_behaves_like 'update_reservation_successfully'
        end
      end

      context 'Failure' do
        include_context 'invalid_payload'

        context 'when guest user email is not uniq' do
          before do
            reservation
            params = booking_params
            params[:reservation][:guest_email] = 'wayne_woodbridge@bnb.com'
            post :create, params: params
          end

          it_behaves_like 'duplicate_guest_email'
        end

        context 'when status is invalid' do
          before do
            params = booking_params
            params[:reservation][:status_type] = 'rejected'
            post :create, params: params
          end

          it_behaves_like 'invalid_status_code'
        end
      end
    end
  end
end

require 'rails_helper'

describe Reservation do
  let(:reservation) { create(:reservation) }

  describe 'Validation' do
    it { is_expected.to validate_presence_of(:code) }
  end

  describe 'Association' do
    it { is_expected.to belong_to(:guest) }
  end

  describe 'accepts_nested_attributes_for' do
    it { is_expected.to accept_nested_attributes_for(:guest).update_only(true) }
  end

  describe 'Enum' do
    it do
      is_expected.to define_enum_for(:status)
        .with_values(%i[accepted cancelled pending])
    end
  end
end

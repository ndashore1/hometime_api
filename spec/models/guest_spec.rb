require 'rails_helper'

describe Guest do
  context '#validation' do
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_presence_of(:email) }
  end
end

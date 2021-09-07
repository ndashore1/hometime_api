FactoryBot.define do
  factory :reservation do
    guest
    code { 'YYY12345111' }
    start_date { '2021-09-01' }
    end_date { '2021-10-30' }
    nights { 4 }
    guests { 4 }
    adults { 2 }
    children { 2 }
    infants { 0 }
    status { 'accepted' }
    currency { 'USD' }
    payout_price { '4200.00' }
    security_price { '500' }
    total_price { '4700.00' }
  end
end

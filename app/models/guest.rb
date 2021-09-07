class Guest < ApplicationRecord
  # validation
  validates :email, uniqueness: true, presence: true
end

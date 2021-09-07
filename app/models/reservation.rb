class Reservation < ApplicationRecord
  enum status: %i[accepted cancelled pending]

  belongs_to :guest

  validates :code, uniqueness: true, presence: true
  validates :status, inclusion: { in: Reservation.statuses.keys, message: :invalid }

  accepts_nested_attributes_for :guest, update_only: true

  def as_json(options = {})
    super(
      {
        except: %i[id created_at updated_at guest_id],
        include: { guest: { except: %i[id created_at updated_at] } }
      }.merge(options)
    )
  end
end

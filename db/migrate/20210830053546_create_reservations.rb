class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.string :code, index: { unique: true }
      t.date :start_date
      t.date :end_date
      t.integer :nights
      t.integer :guests
      t.integer :adults
      t.integer :children
      t.integer :infants
      t.integer :status
      t.string :currency
      t.decimal :payout_price, precision: 10, scale: 2
      t.decimal :security_price, precision: 10, scale: 2
      t.decimal :total_price, precision: 10, scale: 2
      t.belongs_to :guest, foreign_key: true, null: false
      t.string :localized_description

      t.timestamps
    end
  end
end

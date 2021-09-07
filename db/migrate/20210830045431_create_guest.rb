class CreateGuest < ActiveRecord::Migration[6.1]
  def change
    create_table :guests do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email, index: { unique: true }

      t.timestamps
    end
  end
end

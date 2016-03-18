class CreateConstracts < ActiveRecord::Migration
  def change
    create_table :constracts do |t|
      t.integer :hotel_id
      t.string :customer_id_number
      t.string :company_name
      t.string :company_address
      t.string :company_phone
      t.string :booking_rooms
      t.date :check_in_date
      t.date :checkout_out_date
      t.integer :status

      t.timestamps null: false
    end
  end
end

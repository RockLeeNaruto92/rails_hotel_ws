class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :code
      t.string :name
      t.integer :star
      t.string :city
      t.string :country
      t.string :address
      t.string :website
      t.string :phone
      t.integer :total_rooms
      t.integer :available_rooms
      t.integer :cost

      t.timestamps null: false
    end
  end
end

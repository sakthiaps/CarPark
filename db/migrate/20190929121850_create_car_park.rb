class CreateCarPark < ActiveRecord::Migration[6.0]

  def up
    create_table :car_parks do |t|
      t.string :car_park_no, :null => false, :unique => true
      t.string :address, :null => false
      t.float :latitude
      t.float :longitude
      t.integer :total_lots
      t.integer :available_lots
    end
  end

  def down
    drop_table :car_parks
  end
end



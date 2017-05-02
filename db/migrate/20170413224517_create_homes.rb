class CreateHomes < ActiveRecord::Migration[5.0]
  def change
    create_table :homes do |t|
      t.string  :address
      t.string  :city
      t.string  :state
      t.integer :zip
      t.integer :number_bedrooms
      t.integer :number_bathrooms
      t.integer :sq_ft
      t.integer :price
      t.string  :description
      t.integer :created_by_id
      t.text    :image_data
      t.string  :roof
      t.string  :parking
      t.integer :lot_size
      t.boolean :hoa
      t.integer :hoa_fee
      t.integer :number_of_floors
      t.integer :year_built

      t.timestamps
    end
  end
end

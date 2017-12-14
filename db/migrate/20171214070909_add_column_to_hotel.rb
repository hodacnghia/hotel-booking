class AddColumnToHotel < ActiveRecord::Migration[5.1]
  def change
    add_column :hotels, :latitude, :float
    add_column :hotels, :longitude, :float
  end
end

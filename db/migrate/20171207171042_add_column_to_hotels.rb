class AddColumnToHotels < ActiveRecord::Migration[5.1]
  def change
    add_column :hotels, :picture, :string , array: true, default: []
    add_reference :hotels, :city, foreign_key: true
  end
end

class CreateCities < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.string :name_city
      t.string :description_city

      t.timestamps
    end
  end
end

class CreateHotels < ActiveRecord::Migration[5.1]

  def change
    create_table :hotels do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end

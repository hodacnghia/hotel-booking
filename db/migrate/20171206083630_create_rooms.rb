class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.belongs_to :type, foreign_key: true
      # t.belongs_to :hotel, foreign_key: true
      t.integer :bed
      t.decimal :price
      t.boolean :status
      t.references :hotel, foreign_key: true

      t.timestamps
    end
  end
end

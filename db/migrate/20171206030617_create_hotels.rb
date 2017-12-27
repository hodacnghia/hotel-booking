class CreateHotels < ActiveRecord::Migration[5.1]

  def change
    create_table :hotels do |t|
      t.string :name
      t.text :description
      t.belongs_to :user, foreign_key: true
      t.boolean :status, default: false
      
      t.timestamps
    end
  end
end

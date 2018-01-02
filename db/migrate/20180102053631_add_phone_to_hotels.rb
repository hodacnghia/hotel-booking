class AddPhoneToHotels < ActiveRecord::Migration[5.1]
  def change
    add_column :hotels, :phone, :integer
  end
end

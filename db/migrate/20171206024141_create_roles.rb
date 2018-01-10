class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.string :name_role
      t.string :description_role

      t.timestamps
    end
  end
end

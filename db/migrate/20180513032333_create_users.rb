class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :address
      t.boolean :admin, default: false

      t.timestamps
    end
   add_index :users, :address
  end
end

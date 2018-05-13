class ChangeUserAnmeToUserss < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :name, :string
    add_column :users, :nickname, :string
  end
end

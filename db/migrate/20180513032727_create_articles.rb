class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.text :tag
      t.integer :read
      t.integer :user_id
      t.timestamps
    end
  end
end

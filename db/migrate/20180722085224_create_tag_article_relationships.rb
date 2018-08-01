class CreateTagArticleRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :tag_article_relationships do |t|
      t.references :tag, foreign_key: true
      t.references :article, foreign_key: true

      t.timestamps
    end
    add_index :tag_article_relationships, [:tag_id, :article_id], :unique => true
  end
end

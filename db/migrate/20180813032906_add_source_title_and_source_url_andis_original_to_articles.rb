class AddSourceTitleAndSourceUrlAndisOriginalToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :source_title, :string, default: "liuxin's blog"
    add_column :articles, :source_url, :string, default: ""
    add_column :articles, :is_original, :boolean, default: true
  end
end

class Tag < ApplicationRecord
	has_many :tag_article_relationships
  has_many :articles, through: :tag_article_relationships
end

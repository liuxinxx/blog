class Tag < ApplicationRecord
	has_many :tag_article_relationships,dependent: :destroy
  has_many :articles, through: :tag_article_relationships,dependent: :destroy
end

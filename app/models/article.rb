class Article < ApplicationRecord
  belongs_to :user ,optional: true
  has_many :tag_article_relationships
  has_many :tags, through: :tag_article_relationships
  extend FriendlyId
  friendly_id :title, use: :slugged
end

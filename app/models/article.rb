class Article < ApplicationRecord
  belongs_to :user ,optional: true
  extend FriendlyId
  friendly_id :title, use: :slugged
end

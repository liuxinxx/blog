class Article < ApplicationRecord
	belongs_to :user ,optional: true
end

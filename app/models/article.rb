class Article < ApplicationRecord
  belongs_to :user ,optional: true
  has_many :tag_article_relationships,dependent: :destroy
  has_many :tags, through: :tag_article_relationships,dependent: :destroy
  extend FriendlyId
  friendly_id :title

  second_level_cache expires_in: 1.week

  class << self

  	def article_to_md
  		all = Article.all
  		all.each do |a|
  			file = File.open("/Users/liuxin/Me/blog/other/" + a.title+'.md','ab+')

  			print a.title
  			tags = ''
  			a.tags.each do |t|
  				tags+=t.tag_name.to_s+','
  			end
  			tags =  tags[0,tags.size-1]
  			str = "```\r\ntags:" + tags.to_s + "\r\n```\r\n"
  			body = str + a.content
  			file.syswrite(body)
  		end
  	end


  end

end

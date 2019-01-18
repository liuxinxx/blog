class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :prepare_meta_tags, if: "request.get?"

  protected
    def prepare_meta_tags(options={})
      title  = "刘鑫的博客"
      site_name   = "liuxin's blog"
      description = "个人技术博客，记录工作学习中遇到的问题。"
      image       = options[:image] || "https://ws1.sinaimg.cn/large/006tNc79ly1fyucew7ck4j303k03k745.jpg"
      current_url = request.url
      keywords = %w[liuxin blog 刘鑫的博客]

      defaults = {
        site:        site_name,
        title:       title,
        image:       image,
        description: description,
        canonical:   current_url,
        keywords:    %w[liuxin  blog 刘鑫的博客]
      }
      options.reverse_merge!(defaults)
      set_meta_tags options
    end
end

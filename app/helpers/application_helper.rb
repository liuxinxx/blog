module ApplicationHelper
  class CodeRayify < Redcarpet::Render::HTML
    def block_code(code, language)
      language="c" if language=="c++"
      language ||= :plaintext
      begin
        CodeRay.scan(code, language).div
      rescue Exception => e
        language="markdown"
        retry
      end
    end
  end

  def notice_message
    flash_messages = []

    flash.each do |type, message|
      type = :success if type.to_sym == :notice
      type = :danger  if type.to_sym == :alert
      text = content_tag(:div, link_to(raw('<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>'), '#', :class => 'close', 'data-dismiss' => 'alert') + message, class: "alert alert-#{type}")
      flash_messages << text if message
    end

    flash_messages.join("\n").html_safe
  end

end

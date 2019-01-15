module ApplicationHelper

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

  def mobile?
    agent_str = request.user_agent.to_s.downcase
    Rails.logger.info("-----------> agentstr    === #{agent_str}")
    return agent_str =~ /mobile/
  end

end

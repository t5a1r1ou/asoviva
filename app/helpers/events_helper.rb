# frozen_string_literal: true

module EventsHelper
  def event_link(content)
    link_text = content.at('a.m-mainlist-item__ttl').get_attribute(:href)
    "https://www.walkerplus.com#{link_text}"
  end

  def body(content)
    content.at('a.m-mainlist-item__ttl').inner_text
  end

  def description(content)
    content.at('a.m-mainlist-item__txt').inner_text
  end

  def period(content)
    content.at('p.m-mainlist-item-event__period').inner_text
  end

  def image(content)
    "https:#{content.at('img').get_attribute(:src)}"
  end
end

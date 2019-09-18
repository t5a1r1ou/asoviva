# frozen_string_literal: true

class Event
  attr_accessor :contents, :bodies, :descriptions, :periods, :images

  def get_data(area)
    area_codes = Settings.event.area_code_list
    agent = Mechanize.new
    page = agent.get("https://www.walkerplus.com/ranking/event/#{area_codes[area.to_sym]}/1.html")
    @contents = page.search('div.m-mainlist-item')
  end
end

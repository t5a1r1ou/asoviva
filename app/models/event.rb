# frozen_string_literal: true

class Event
  attr_accessor :contents, :bodies, :descriptions, :periods, :images

  def get_data(area)
    area_codes = {
      hokkaido: 'ar0101',
      tohoku: 'ar0200',
      kanto: 'ar0300',
      koushinetsu: 'ar0400',
      tokai: 'ar0500',
      hokuriku: 'ar0600',
      kansai: 'ar0700',
      chugoku: 'ar0800',
      shikoku: 'ar0900',
      kyushu: 'ar1000'
    }
    area_code = area_codes[area.to_sym]
    agent = Mechanize.new
    page = agent.get("https://www.walkerplus.com/ranking/event/#{area_code}/1.html")
    @contents = page.search('div.m-mainlist-item')
  end
end

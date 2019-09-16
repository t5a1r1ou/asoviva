# frozen_string_literal: true

class OgpCreator
  require 'mini_magick'

  def self.build(text)
    text = prepare_text(text)
    image = MiniMagick::Image.open(Settings.ogp.base_image_path)
    image.combine_options do |config|
      config.font Settings.ogp.font
      config.fill 'black'
      config.gravity Settings.ogp.gravity
      config.pointsize Settings.ogp.font_size
      config.draw "text #{Settings.ogp.text_position} '#{text}'"
    end
  end

  def self.prepare_text(text)
    text.to_s.scan(/.{1,#{Settings.ogp.idention_count}}/)[0...Settings.ogp.row_limit].join("\n")
  end
end

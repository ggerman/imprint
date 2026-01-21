# frozen_string_literal: true

require 'pry'
require 'gd'
require 'securerandom'
require 'tmpdir'

module Imprint
  class Renderer
    DEFAULT_FONT_SIZE = 24

    def self.render(source:, watermark:)
      raise ArgumentError, 'source image not found' unless File.exist?(source)

      image = GD::Image.open(source)

      apply_watermark(image, watermark)

      output = File.join(
        Dir.tmpdir,
        "imprint-#{SecureRandom.hex(8)}.png"
      )

      image.save(output)
      output
    end

    def self.apply_watermark(image, text)
      color = GD::Color.rgba(0, 116, 139, 225)

      raise "Font missing" unless File.exist?(default_font)

      image.text(
        text,
        x: 20,
        y: image.height - 20,
        size: DEFAULT_FONT_SIZE,
        color: color,
        font: default_font
      )
    end

    def self.default_font
      @default_font ||= begin
        font = '/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf'
        raise 'Font not found' unless File.exist?(font)

        font
      end
    end
  end
end

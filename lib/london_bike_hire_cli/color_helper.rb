module LondonBikeHireCli
  module ColorHelper
    def colorize(text, color_name = :default)
      colour_code = color_code(color_name)
      "\e[#{colour_code}m#{text}\e[0m"
    end

    private

    def color_code(name)
      COLOR_MAP[name]
    end

    COLOR_MAP = {
      default: 39,
      red: 31,
      green: 32,
      yellow: 33,
      blue: 34,
      pink: 35,
      cyan: 36
    }.freeze
  end
end
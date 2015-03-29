require 'ostruct'

module LondonBikeHireCli
  class Station < OpenStruct
    def map_link
      "https://www.google.co.uk/maps/preview/@#{lat},#{long},17z"
    end

    def position
      {
        lat: lat,
        long: long
      }
    end

    def display_feed_time
      updated_at.strftime('%Y-%m-%d %H:%M:%S')
    end
  end
end

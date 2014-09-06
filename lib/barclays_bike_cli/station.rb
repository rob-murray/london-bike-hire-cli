require 'ostruct'

module BarclaysBikeCli
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
  end
end

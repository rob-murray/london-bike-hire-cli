require 'geocoder'

module BarclaysBikeCli
  class GeocodingAdapter

    def geocode(search)
      results = Geocoder.search(search)

      if results && results.any?
        p = results.first.coordinates
        { lat: p[0], long: p[1] }
      end
    end
  end
end

require 'geocoder'

module BarclaysBikeCli
  class GeocodingAdapter
    def geocode(search_term)
      prepare_results Geocoder.search(search_term)
    end

    private

    def prepare_results(results)
      unless results && results.any?
        return {}
      end

      first_result_coords = results.first.coordinates

      {
        lat: first_result_coords[0],
        long: first_result_coords[1]
      }
    end
  end
end

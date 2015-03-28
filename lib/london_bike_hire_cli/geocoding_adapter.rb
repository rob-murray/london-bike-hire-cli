require 'geocoder'

module LondonBikeHireCli
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
      result(first_result_coords)
    end

    def result(coordinates)
      {
        lat: coordinates[0],
        long: coordinates[1]
      }
    end
  end
end

module LondonBikeHireCli
  class StationRepository
    class StationNotFound < StandardError; end

    def initialize(datasource)
      @datasource = datasource
    end

    def all
      return_query_obj(stations.values)
    end

    def find_by_id(*station_ids)
      if station_ids.size == 1
        matched_stations = stations[station_ids.first]
      else
        matched_stations = stations.values_at(*station_ids)
      end

      fail StationNotFound unless matched_stations

      return_query_obj(matched_stations)
    end

    def find_by_name(station_name)
      search_term = normalize_search_term(station_name)
      results = stations.select { |_id, station| station.name.downcase.include?(search_term) }
      return_query_obj(results.values)
    end

    private

    attr_reader :datasource, :last_update

    def normalize_search_term(input)
      input.downcase
    end

    def return_query_obj(results)
      QueryResponse.new(last_update: last_update, results: Array(results))
    end

    def stations
      @stations ||= begin
        results = datasource.fetch
        @last_update = results.delete(:last_update)
        results
      end
    end
  end
end

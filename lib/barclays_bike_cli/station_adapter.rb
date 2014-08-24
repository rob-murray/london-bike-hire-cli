module BarclaysBikeCli
  class StationAdapter
    def initialize(stations)
      @stations = stations
    end

    # Public: Produce array of station triples
    # E.g. [51.50810309, -0.12602103, 2]
    # As used by kdtree.
    # ids - Filter stations by id
    #
    def to_triples(*ids)
      if ids.size > 0
        selected_stations = stations.select { |s| ids.include? s.id }
        map_stations(selected_stations)
      else
        map_stations(stations)
      end
    end

    private

    attr_reader :stations

    def map_stations(station_list)
      station_list.map { |station| [station.lat, station.long, station.id]  }
    end
  end
end

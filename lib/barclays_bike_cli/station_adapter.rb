module BarclaysBikeCli
  class StationAdapter
    def initialize(stations)
      @stations = stations
    end

    # Public: Produce array of station triples
    # E.g. [51.50810309, -0.12602103, 2]
    # As used by kdtree
    #
    def to_triples
      stations.map { |station| [station.lat, station.long, station.id] }
    end

    private

    attr_reader :stations
  end
end

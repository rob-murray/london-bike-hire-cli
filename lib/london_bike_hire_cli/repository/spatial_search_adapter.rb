require "kdtree"

module LondonBikeHireCli
  module Repository
    class SpatialSearchAdapter
      def initialize(stations = [])
        init_spatial_store(stations)
      end

      # Public: Return the IDs of the nearest n stations
      # lat, long - latitude, longitude of point to search
      # limit - The maximum number of results
      #
      def nearest(lat, long, limit)
        spatial_store.nearestk(lat, long, limit)
      end

      private

      attr_reader :spatial_store

      def init_spatial_store(stations)
        stations_triples = stations.map { |station| [station.lat, station.long, station.id] }
        @spatial_store = Kdtree.new(stations_triples)
      end
    end
  end
end

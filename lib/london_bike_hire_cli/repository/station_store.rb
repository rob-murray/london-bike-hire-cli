require 'kdtree'

module LondonBikeHireCli
  module Repository
    class StationStore < InMemoryStore
      def query_stations_by_name(klass, query)
        all(klass).select { |station| station.name.downcase.include?(query.normalized_query) }
      end

      def query_stations_near(klass, query)
        matched_ids = spatial_store(klass).nearestk(query.lat, query.long, query.limit)
        find_by_ids(klass, *matched_ids)
      end

      def find_by_ids(klass, *ids)
        map_for_class(klass).values_at(*ids)
      end

      private

      def spatial_store(klass)
        stations_triples = all(klass).map { |station| [station.lat, station.long, station.id] }
        @spatial_store ||= Kdtree.new(stations_triples)
      end
    end
  end
end

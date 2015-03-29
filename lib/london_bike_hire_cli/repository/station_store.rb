module LondonBikeHireCli
  module Repository
    # Specialisation for Bike Stations; implements specific queries
    #
    class StationStore < InMemoryStoreAdapter
      def query_stations_by_name(klass, query)
        all(klass).select { |station| station.name.downcase.include?(query.normalized_query) }
      end

      def query_stations_near(klass, query)
        matched_ids = spatial_search_adapter(klass).nearest(query.lat, query.long, query.limit)
        find_by_ids(klass, *matched_ids)
      end

      private

      def spatial_search_adapter(klass)
        @spatial_search_adapter ||= SpatialSearchAdapter.new all(klass)
      end
    end
  end
end

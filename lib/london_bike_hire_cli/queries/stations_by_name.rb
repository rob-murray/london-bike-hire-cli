module LondonBikeHireCli
  module Queries
    StationsByName = Struct.new(:search_term) do
      def normalized_query
        search_term.downcase
      end
    end
  end
end

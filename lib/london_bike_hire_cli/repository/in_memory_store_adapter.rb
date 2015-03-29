module LondonBikeHireCli
  module Repository
    # Adapter that stores records in memory.
    # Supports multiple record types
    #
    class InMemoryStoreAdapter
      def initialize(items = [])
        @counter = 0
        @map = {}
        add_items(items)
      end

      def create(record)
        @counter = @counter + 1
        record.id ||= @counter
        map_for(record)[record.id] = record
      end

      def update(record)
        map_for(record)[record.id] = record
      end

      def delete(record)
        map_for(record).delete record.id
      end

      def find(klass, id)
        map_for_class(klass).fetch id
      end

      def find_by_ids(klass, *ids)
        map_for_class(klass).values_at(*ids)
      end

      def all(klass)
        map_for_class(klass).values
      end

      def query(klass, selector)
        # TODO fix introspection
        send "query_#{underscore(selector.class.name)}", klass, selector
      end

      private

      def add_items(items)
        items.each { |item| create(item) }
      end

      def map_for_class(klass)
        @map[klass.to_s.to_sym] ||= {}
      end

      def map_for(record)
        map_for_class(record.class)
      end

      # TODO fix
      def underscore(camel_cased_word)
        demod_word = camel_cased_word.to_s.split('::').last
        demod_word.gsub!(/([A-Z\d]+)([A-Z][a-z])/,'\1_\2')
        demod_word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
        demod_word.tr!("-", "_")
        demod_word.downcase!
        demod_word
      end
    end
  end
end

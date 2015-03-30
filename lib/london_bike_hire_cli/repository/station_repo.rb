module LondonBikeHireCli
  module Repository
    # Specialisation for Bike Stations; delegates all to Repository
    #
    class StationRepo
      def save(record)
        Repo.save(record)
      end

      def all
        Repo.all object_class
      end

      def find(id)
        Repo.find object_class, id
      end

      def delete(record)
        Repo.delete record
      end

      def query(selector)
        Repo.query object_class, selector
      end

      private

      def object_class
        # TODO fix reflection
        #@object_class ||= self.to_s.match(/^(.+)Repo/)[1].constantize
        Station
      end
    end
  end
end

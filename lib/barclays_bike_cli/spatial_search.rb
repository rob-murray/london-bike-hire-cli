require 'kdtree'

module BarclaysBikeCli
  class SpatialSearch
    def initialize(datasource)
      @stations = Kdtree.new(datasource)
    end

    # Public: Return the IDs of the nearest n stations
    # point - a 2d point; { lat: x.x, long: x.x }
    # limit - The maximum number of results
    def nearest(point, limit: 5)
      stations.nearestk(point[:lat], point[:long], limit)
    end

    private

    attr_reader :stations
  end
end

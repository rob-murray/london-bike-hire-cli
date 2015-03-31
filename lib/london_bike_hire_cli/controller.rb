module LondonBikeHireCli
  class Controller
    attr_accessor :geocoder

    def initialize(repository: nil, renderer: default_renderer)
      @repository = repository
      @renderer = renderer
      @geocoder = GeocodingAdapter.new
    end

    def all
      results = repository.all
      renderer.render(:stations, results)
    end

    def find_by_id(id)
      results = repository.find(id.to_i)
      renderer.render(:stations, Array(results))

    rescue StationNotFoundError => e
      renderer.render(:error, query: "find_by_id: #{id}", error: e)
    end

    def where(params: {})
      by_name_query = Queries::StationsByName.new(params[:name])
      results = repository.query(by_name_query)
      renderer.render(:stations, results)

    rescue StationNotFoundError => e
      renderer.render(:error, query: "where: #{params}", error: e)
    end

    def nearest(params: {})
      unless params[:search_term].nil? ^ params[:id].nil?
        error = 'Please use either `search_term` or `id` not both.'
        renderer.render(:error, query: "nearest: #{params}", error: error)
        return
      end

      if search_term = params[:search_term]
        geocoded_point = geocoder.geocode(search_term)
      elsif search_term = params[:id]
        begin
          station = repository.find(search_term.to_i)
        rescue StationNotFoundError => e
          renderer.render(:error, query: "where: #{params}", error: e)
          return
        end

        geocoded_point = station.position
      end

      unless geocoded_point
        error = 'Unable to Geocode location.'
        renderer.render(:error, query: "nearest: #{params}", error: error)
        return
      end

      near_query = Queries::StationsNear.new(geocoded_point[:lat], geocoded_point[:long], DEFAULT_SEARCH_LIMIT)
      results = repository.query(near_query)
      renderer.render(:stations, results)
    end

    private

    attr_reader :repository, :renderer

    def default_renderer
      BasicRenderer.new
    end
  end
end

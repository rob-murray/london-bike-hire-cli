module BarclaysBikeCli
  class Controller
    attr_accessor :geocoder, :spatial_service

    def initialize(repository: nil, renderer: default_renderer)
      @repository = repository
      @renderer = renderer
      @geocoder = GeocodingAdapter.new
    end

    def all
      results = repository.all
      renderer.render(results)
    end

    def find_by_id(id)
      results = repository.find_by_id(id.to_i)
      renderer.render(results)

    rescue StationRepository::StationNotFound => e
      renderer.render_error(query: "find_by_id: #{id}", error: e)
    end

    def where(params: {})
      results = repository.find_by_name(params[:name])
      renderer.render(results)

    rescue StationRepository::StationNotFound => e
      renderer.render_error(query: "where: #{params}", error: e)
    end

    def nearest(params: {})
      if search_term = params[:search_term]
        geocoded_point = geocoder.geocode(search_term)
      end

      unless geocoded_point
        error = 'Unable to Geocode location.'
        renderer.render_error(query: "nearest: #{params}", error: error)
        return
      end

      init_spatial_service(repository.all)
      nearest_ids = spatial_service.nearest(geocoded_point)

      results = repository.all_ids(nearest_ids)
      renderer.render(results)
    end

    private

    attr_reader :repository, :renderer

    def default_renderer
      BasicRenderer.new
    end

    def init_spatial_service(stations)
      @spatial_service ||= begin
        datasource = StationAdapter.new(stations).to_triples
        SpatialSearch.new(datasource)
      end
    end
  end
end

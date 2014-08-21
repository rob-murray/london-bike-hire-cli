module BarclaysBikeCli
  class Controller
    def initialize(repository: nil, renderer: default_renderer)
      @repository = repository
      @renderer = renderer
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
      params[:post_code]
      # do geocoding

      datasource = StationAdapter.new(repository.all).to_triples
      nearest_ids = spatial_service(datasource).nearest({ lat: 51.5309, long: -0.1215 })

      results = repository.all_ids(nearest_ids)
      renderer.render(results)
    end

    private

    attr_reader :repository, :renderer

    def default_renderer
      BasicRenderer.new
    end

    def spatial_service(datasource)
      SpatialSearch.new(datasource)
    end
  end
end

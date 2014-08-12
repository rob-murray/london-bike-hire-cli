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

    def find_by_id(id: nil)
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

    private

    attr_reader :repository, :renderer

    def default_renderer
      BasicRenderer.new
    end
  end
end

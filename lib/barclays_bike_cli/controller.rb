module BarclaysBikeCli
  class Controller
    def initialize(repository)
      @repository = repository
    end

    def find_by_id(id)
      results = repository.find_by_id id.to_i

      renderer.render results

    rescue StationRepository::StationNotFound => e
      renderer.render_error(query: "find_by_id: #{id}", error: e)
    end

    def find_by_name(name)
      results = repository.find_by_name name

      renderer.render results
    end

    private

    attr_reader :repository

    def renderer
      @renderer ||= BasicRenderer.new
    end
  end
end

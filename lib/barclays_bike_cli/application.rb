require 'commander'

module BarclaysBikeCli
  class Application
    include Commander::Methods

    def run
      program :name, 'Barclays Bike London CLI'
      program :version, BarclaysBikeCli::VERSION
      program :description, 'A command line interface to Barclays Bike API.'

      command :find do |c|
        c.option '--id ID', Integer, 'The Bike station ID'
        c.syntax = 'find --id {id}'
        c.description = 'Find by id. The id is the idenitifier given by TFL to each Bike Station.'
        c.action do |_args, options|
          controller.find_by_id(options.id)
        end
      end

      command :where do |c|
        c.option '--name NAME', String, 'The name attribute to search'
        c.syntax = 'where --name {name}'
        c.description = 'Search all stations for name or partial.'
        c.action do |_args, options|
          enable_paging

          controller.where(params: { name: options.name })
        end
      end

      command :near do |c|
        c.option '--postcode POSTCODE', String, 'Postcode to base search around'
        c.syntax = 'near --postcode {postcode}'
        c.description = 'Search for the nearest 5 stations to the given postcode.'
        c.action do |_args, options|
          enable_paging

          controller.nearest(params: { postcode: options.postcode })
        end
      end

      command :all do |c|
        c.syntax = 'all'
        c.description = 'List all stations.'
        c.action do |_args, _options|
          enable_paging

          controller.all
        end
      end

      run!
    end

    private

    def controller
      @controller ||= Controller.new(repository: station_repository)
    end

    def station_repository
      @station_repository ||= StationRepository.new(FeedParser.new)
    end
  end
end

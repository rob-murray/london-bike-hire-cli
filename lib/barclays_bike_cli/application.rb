require 'commander'

module BarclaysBikeCli
  class Application
    include Commander::Methods

    def run
      program :name, 'Barclays Bike London CLI'
      program :version, BarclaysBikeCli::VERSION
      program :description, 'A command line interface to Barclays Bike API.'

      command :find do |c|
        c.syntax = 'find id'
        c.description = 'Find by id'
        c.action do |args, _options|
          controller.find_by_id args.first
        end
      end

      run!
    end

    private

    def controller
      @controller ||= Controller.new(station_repository)
    end

    def station_repository
      @station_repository ||= StationRepository.new(FeedParser.new)
    end
  end
end

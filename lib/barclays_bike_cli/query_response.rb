require 'forwardable'

module BarclaysBikeCli
  class QueryResponse
    extend Forwardable

    def_delegators :results, :[], :each, :map, :first, :size

    def initialize(last_update: Time.now, results: [])
      @last_update = last_update
      @results = results
    end

    def time_of_feed
      last_update.strftime('%Y-%m-%d %H:%M:%S')
    end

    private

    attr_reader :results, :last_update
  end
end

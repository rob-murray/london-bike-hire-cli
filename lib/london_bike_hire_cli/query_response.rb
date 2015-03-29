require 'forwardable'

module LondonBikeHireCli
  class QueryResponse
    extend Forwardable

    def_delegators :results, :[], :each, :map, :first, :size

    attr_reader :last_update

    def initialize(last_update: Time.now, results: [])
      @last_update = last_update
      @results = results
    end

    private

    attr_reader :results
  end
end

require 'delegate'

module LondonBikeHireCli
  class QueryResponse < SimpleDelegator
    attr_reader :last_update

    def initialize(last_update: Time.now, results: [])
      super(results)
      @last_update = last_update
    end
  end
end

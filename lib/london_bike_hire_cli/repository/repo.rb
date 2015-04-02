module LondonBikeHireCli
  module Repository
    # Generic Repository delegating to adapter
    #
    module Repo
      class << self
        attr_reader :adapter

        def register(adapter)
          @adapter = adapter
        end

        def find(klass, id)
          adapter.find klass, id
        end

        def all(klass)
          adapter.all klass
        end

        def create(model)
          adapter.create(model)
        end

        def update(model)
          adapter.update(model)
        end

        def delete(model)
          adapter.delete model
        end

        def query(klass, selector)
          adapter.query(klass, selector)
        end
      end
    end
  end
end

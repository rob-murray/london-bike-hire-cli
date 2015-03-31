require 'erb'
require_relative 'color_helper'

module LondonBikeHireCli
  class BasicRenderer
    include LondonBikeHireCli::ColorHelper

    def initialize(output = STDOUT)
      @output = output
    end

    attr_reader :context

    def render(context)
      @context = context
      output.print build(station_list_template).result(binding).gsub(/^\s+/, "")
    end

    def render_error(context)
      @context = context
      output.print build(error_view).result(binding).gsub(/^\s+/, "")
    end

    private

    attr_reader :output

    def build(template)
      ERB.new(template)
    end

    def station_list_template
      File.read('lib/london_bike_hire_cli/views/stations.erb')
    end

    def error_view
      File.read('lib/london_bike_hire_cli/views/error.erb')
    end
  end
end

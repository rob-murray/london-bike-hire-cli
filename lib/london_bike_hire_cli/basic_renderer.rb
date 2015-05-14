require 'erb'
require_relative 'color_helper'

module LondonBikeHireCli
  class BasicRenderer
    include ColorHelper

    def initialize(output = STDOUT)
      @output = output
    end

    attr_reader :context

    def render(template_name, context)
      @context = context
      output.print render_template(find_template(template_name))
    end

    private

    attr_reader :output

    def render_template(template)
      ERB.new(template).result(binding).gsub(/^\s+/, '')
    end

    def find_template(template_name)
      File.read("#{template_dir}/#{template_name}.erb")
    end

    def template_dir
      File.expand_path('../views/', __FILE__)
    end
  end
end

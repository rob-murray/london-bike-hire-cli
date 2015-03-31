module LondonBikeHireCli
  class BasicRenderer
    def initialize(output = STDOUT)
      @output = output
    end

    def render(context)
      print_line colourize(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>", :yellow)
      print_line "Feed updated: #{colourize(context.first.display_feed_time, :red)}"

      context.each do |station|
        render_station(station)
      end

      print_line colourize(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>", :yellow)
    end

    def render_error(context)
      print_line colourize(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>", :yellow)
      print_line colourize("Ooops, something went wrong with the query.", :red)
      print_line colourize("The query #{context[:query].inspect}", :cyan)
      print_line colourize("resulted in error: #{context[:error]}", :cyan)
      print_line colourize("Try again?", :yellow)
    end

    private

    attr_reader :output

    def render_station(station)
      print_line "%s %s" % [colourize('>>>>', :yellow), colourize('Bike station', :blue)]
      station.each_pair.each do |attr_name, attr_value|
        print_line "#{attr_name.capitalize}: #{colourize(attr_value, :cyan)}"
      end
      print_line "Link to map: #{colourize(station.map_link, :pink)}"
    end

    def print_line(text, line_ending = "\n")
      output.print "%s %s" % [text, line_ending]
    end

    def colourize(text, color_name = :default)
      colour_code = colour_code(color_name)
      "\e[#{colour_code}m#{text}\e[0m"
    end

    def colour_code(name)
      COLOUR_MAP[name]
    end

    COLOUR_MAP = {
      default: 39,
      red: 31,
      green: 32,
      yellow: 33,
      blue: 34,
      pink: 35,
      cyan: 36
    }.freeze
  end
end

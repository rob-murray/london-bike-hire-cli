module LondonBikeHireCli
  class BasicRenderer
    def initialize(output = STDOUT)
      @output = output
    end

    def render(context)
      output.print ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n"
      output.print "Feed updated: #{context.time_of_feed}\n"

      context.each do |station|
        render_station(station)
      end

      output.print ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n"
    end

    def render_error(context)
      output.print ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n"
      output.print "Ooops, something went wrong with the query.\n"
      output.print "The query #{context[:query].inspect}\n"
      output.print "resulted in error: #{context[:error]}\n"
      output.print "Try again?\n"
    end

    private

    attr_reader :output

    def render_station(station)
      output.print ">>> Dock\n"
      station.each_pair.each do |attr_name, attr_value|
        output.print "#{attr_name.capitalize}: #{attr_value}\n"
      end
      output.print "Link to map: #{station.map_link}\n"
    end
  end
end

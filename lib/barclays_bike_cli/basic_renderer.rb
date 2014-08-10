module BarclaysBikeCli
  class BasicRenderer
    def initialize(output = STDOUT)
      @output = output
    end

    def render(context)
      output.print ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n"
      output.print "Feed updated: #{context.time_of_feed}\n"

      context.each do |station|
        output.print ">>> Dock\n"
        output.print "Id: #{station.id}\n"
        output.print "Name: #{station.name}\n"
        output.print "Docks free: #{station.docks_free}\n"
        output.print "Docks total: #{station.docks_total}\n"
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
  end
end

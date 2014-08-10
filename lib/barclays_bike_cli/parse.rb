require 'awesome_print'
require_relative 'feed_parser'
require_relative 'station_repository'
require_relative 'controller'

station_repo = StationRepository.new(FeedParser.new)

controller = Controller.new station_repo

controller.find_by_id '92939339'
controller.find_by_name 'kings'

# Kernel.ap stations[:last_update]
# s = station_repo.find_by_id('777')

# Kernel.ap s
# Kernel.ap s.time_of_feed
# Kernel.ap s.first.name
# Kernel.ap s.first.docks_free

# stations = station_repo.find_by_name('kings')

# stations.each do |s|
#   Kernel.ap s.name
#   Kernel.ap s.docks_free
# end

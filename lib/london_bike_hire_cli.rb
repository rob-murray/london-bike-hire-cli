module LondonBikeHireCli
  DEFAULT_SEARCH_LIMIT = 5
end

require_relative 'london_bike_hire_cli/application'
require_relative 'london_bike_hire_cli/basic_renderer'
require_relative 'london_bike_hire_cli/controller'
require_relative 'london_bike_hire_cli/feed_parser'
require_relative 'london_bike_hire_cli/geocoding_adapter'
require_relative 'london_bike_hire_cli/query_response'
require_relative 'london_bike_hire_cli/station'
require_relative 'london_bike_hire_cli/repository/repo'
require_relative 'london_bike_hire_cli/repository/in_memory_store_adapter'
require_relative 'london_bike_hire_cli/repository/station_store'
require_relative 'london_bike_hire_cli/repository/station_repo'
require_relative 'london_bike_hire_cli/repository/spatial_search_adapter'
require_relative 'london_bike_hire_cli/queries/stations_by_name'
require_relative 'london_bike_hire_cli/queries/stations_near'
require_relative 'london_bike_hire_cli/station_not_found_error'
require_relative 'london_bike_hire_cli/version'

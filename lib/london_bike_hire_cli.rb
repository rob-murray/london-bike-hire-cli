Dir[File.dirname(__FILE__) + "/london_bike_hire_cli/**/*.rb"].each { |file| require file }

module LondonBikeHireCli
  DEFAULT_SEARCH_LIMIT = 5
end

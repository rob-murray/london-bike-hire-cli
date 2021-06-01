require 'nokogiri'
require 'open-uri'

module LondonBikeHireCli
  class FeedParser
    TFL_FEED_URL = 'https://tfl.gov.uk/tfl/syndication/feeds/cycle-hire/livecyclehireupdates.xml'.freeze

    def fetch
      stations_doc = Nokogiri::XML(
        URI.parse(TFL_FEED_URL).open('User-Agent' => 'Mozilla/5.0 (Windows NT 5.1; rv:31.0) Gecko/20100101 Firefox/31.0')
      )

      parse_xml(stations_doc)
    end

    private

    attr_reader :feed_time

    def parse_xml(xml_doc)
      parse_feed_time(xml_doc)

      stations = xml_doc.root.elements.inject([]) do |collection, node|
        collection << parse_station(node)
      end

      QueryResponse.new(last_update: feed_time, results: stations)
    end

    def parse_feed_time(xml_doc)
      @feed_time ||= Time.at xml_doc.root['lastUpdate'].to_i / 1000
    end

    # <stations lastUpdate="1407153481506" version="2.0">
    #   <station>
    #     <id>1</id>
    #     <name>River Street , Clerkenwell</name>
    #     <terminalName>001023</terminalName>
    #     <lat>51.52916347</lat>
    #     <long>-0.109970527</long>
    #     <installed>true</installed>
    #     <locked>false</locked>
    #     <installDate>1278947280000</installDate>
    #     <removalDate/>
    #     <temporary>false</temporary>
    #     <nbBikes>8</nbBikes>
    #     <nbEmptyDocks>11</nbEmptyDocks>
    #     <nbDocks>19</nbDocks>
    #   </station>
    #   ...
    # </stations>

    def parse_station(xml_node)
      station = {}

      xml_node.elements.each do |node|
        station[:id] = node.text.to_i if node.node_name.eql? 'id'
        station[:name] = node.text if node.node_name.eql? 'name'
        station[:docks_free] = node.text.to_i if node.node_name.eql? 'nbEmptyDocks'
        station[:docks_total] = node.text.to_i if node.node_name.eql? 'nbDocks'
        station[:bikes] = node.text.to_i if node.node_name.eql? 'nbBikes'
        station[:lat] = node.text.to_f if node.node_name.eql? 'lat'
        station[:long] = node.text.to_f if node.node_name.eql? 'long'
        station[:temporary] = parse_bool(node.text) if node.node_name.eql? 'temporary'
        station[:updated_at] = feed_time
      end

      Station.new(station)
    end

    def parse_bool(value)
      !!(value == 'true')
    end
  end
end

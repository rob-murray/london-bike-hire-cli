require 'spec_helper'

RSpec.describe BarclaysBikeCli::FeedParser do
  subject { BarclaysBikeCli::FeedParser.new }

  describe '#fetch', vcr: { cassette_name: 'feed_xml' } do
    it 'parses expected number of Bike Stations' do
      expect(subject.fetch).not_to be_nil
    end

    it 'parses expected number of Bike Stations' do
      results = subject.fetch
      expect(results.keys.count).to eq(747 + 1)
    end

    it 'has the feed update time' do
      results = subject.fetch
      expect(results).to have_key(:last_update)
    end

    it 'has integer for all Stations' do
      results = subject.fetch
      results.delete(:last_update)

      expect(results.keys).to all( be_an(Integer) )
    end

    it 'has parsed date time from feed update time' do
      results = subject.fetch
      expect(results[:last_update]).to eq(Time.new(2014, 8, 10, 10, 56, 01,'+01:00'))
    end
  end
end

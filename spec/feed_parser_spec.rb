require 'spec_helper'

RSpec.describe LondonBikeHireCli::FeedParser do
  subject { described_class.new }

  describe '#fetch', vcr: { cassette_name: 'feed_xml' } do
    it 'parses expected number of Bike Stations' do
      expect(subject.fetch).not_to be_nil
    end

    it 'returns query response' do
      expect(subject.fetch).to be_instance_of(LondonBikeHireCli::QueryResponse)
    end

    it 'parses expected number of Bike Stations' do
      results = subject.fetch
      expect(results.size).to eq(747)
    end

    it 'has returns array of Stations' do
      results = subject.fetch

      # TODO fix the enumerator thing
      expect(results.map {|s| s}).to all(be_an(LondonBikeHireCli::Station))
    end

    it 'has integer for all Station IDs' do
      results = subject.fetch
      ids = results.map(&:id)

      expect(ids).to all(be_an(Integer))
    end

    it 'has parsed date time from feed update time' do
      results = subject.fetch
      expected_time = Time.new(2014, 8, 10, 10, 56, 01, '+01:00')
      expect(results.last_update).to eq(expected_time)
    end
  end
end

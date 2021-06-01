require 'spec_helper'

RSpec.describe LondonBikeHireCli::GeocodingAdapter do
  subject { described_class.new }

  describe '#geocode with valid search term', vcr: { cassette_name: 'n19ae_geocode' } do
    let(:search_term) { 'n1 9ae' }

    it 'returns hash' do
      expect(subject.geocode(search_term)).to be_instance_of(Hash)
    end

    it 'returns 2d point with lat and long' do
      point = subject.geocode(search_term)

      expect(point[:lat]).to eq(51.53098117574372)
      expect(point[:long]).to eq(-0.12184057148593619)
    end
  end

  describe '#geocode with search term returning no results', vcr: { cassette_name: 'no_results_geocode' } do
    let(:search_term) { '====' }

    it 'returns non nil' do
      expect(subject.geocode(search_term)).not_to be_nil
    end

    it 'returns hash' do
      expect(subject.geocode(search_term)).to be_instance_of(Hash)
    end

    it 'returns emtpy hash' do
      expect(subject.geocode(search_term)).to be_empty
    end
  end
end

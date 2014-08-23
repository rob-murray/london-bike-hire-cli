require 'spec_helper'

RSpec.describe BarclaysBikeCli::GeocodingAdapter do
  subject { BarclaysBikeCli::GeocodingAdapter.new }

  describe '#geocode with valid search term', vcr: { cassette_name: 'n19ae_geocode' } do
    let(:search_term) { 'n19ae' }

    it 'returns hash' do
      expect(subject.geocode(search_term)).to be_instance_of(Hash)
    end

    it 'returns 2d point with lat key' do
      expect(subject.geocode(search_term)).to have_key(:lat)
    end

    it 'returns 2d point with lat key' do
      expect(subject.geocode(search_term)).to have_key(:long)
    end

    it 'returns 2d point with lat value' do
      point = subject.geocode(search_term)
      expect(point[:lat]).to eq(51.5309584)
    end

    it 'returns 2d point with long value' do
      point = subject.geocode(search_term)
      expect(point[:long]).to eq(-0.1215387)
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

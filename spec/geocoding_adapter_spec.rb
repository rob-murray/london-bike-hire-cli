require 'spec_helper'

RSpec.describe BarclaysBikeCli::GeocodingAdapter do
  subject { BarclaysBikeCli::GeocodingAdapter.new }

  describe '#geocode', vcr: { cassette_name: 'n19ae_geocode' } do
    it 'returns 2d point with lat key' do
      expect(subject.geocode('n19ae')).to have_key(:lat)
    end

    it 'returns 2d point with lat key' do
      expect(subject.geocode('n19ae')).to have_key(:long)
    end

    it 'returns 2d point with lat value' do
      point = subject.geocode('n19ae')
      expect(point[:lat]).to eq(51.5309584)
    end

    it 'returns 2d point with long value' do
      point = subject.geocode('n19ae')
      expect(point[:long]).to eq(-0.1215387)
    end
  end
end

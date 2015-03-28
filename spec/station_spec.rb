require 'spec_helper'

RSpec.describe LondonBikeHireCli::Station do
  let(:params) do
    { id: 1, name: 'test-station-1', docks_total: 30, docks_free: 10, lat: 51.53005939, long: -0.120973687 }
  end
  subject { described_class.new(params) }

  describe '#map_link' do
    it 'returns a link with lat and long' do
      expect(subject.map_link).to eq('https://www.google.co.uk/maps/preview/@51.53005939,-0.120973687,17z')
    end
  end

  describe '#position' do
    it 'returns a hash' do
      expect(subject.position).to be_instance_of(Hash)
    end

    it 'contains latitude value' do
      expect(subject.position[:lat]).to eq(params[:lat])
    end

    it 'contains longitude value' do
      expect(subject.position[:long]).to eq(params[:long])
    end
  end
end

require 'spec_helper'

RSpec.describe BarclaysBikeCli::Station do
  let(:params) do
    { id: 1, name: 'test-station-1', docks_total: 30, docks_free: 10, lat: 51.53005939, long: -0.120973687 }
  end
  subject { BarclaysBikeCli::Station.new(params) }

  describe '#map_link' do
    it 'returns a link with lat and long' do
      expect(subject.map_link).to eq('https://www.google.co.uk/maps/preview/@51.53005939,-0.120973687,17z')
    end
  end
end

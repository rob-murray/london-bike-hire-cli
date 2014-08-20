require 'spec_helper'

RSpec.describe BarclaysBikeCli::SpatialSearch do
  let(:point_1) { [51.53005939, -0.120973687, 1] }
  let(:point_2) { [51.50810309, -0.12602103, 2] }
  let(:datasource) { [point_1, point_2] }
  subject { BarclaysBikeCli::SpatialSearch.new(datasource) }

  describe '#nearest' do
    context 'with datasource' do
      let(:request) { { lat: 51.5309, long: -0.1215 } }
      it 'returns results ordered by distance' do
        results = subject.nearest(request)

        expect(results).to eq([1, 2])
      end

      context 'given a limit request' do
        it 'returns correct number of results' do
          results = subject.nearest(request, limit: 1)

          expect(results.size).to eq(1)
        end
      end
    end
  end
end

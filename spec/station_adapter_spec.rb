require 'spec_helper'

RSpec.describe BarclaysBikeCli::StationAdapter do
  let(:datasource) { TestDatasource.new }
  let(:test_repository) { BarclaysBikeCli::StationRepository.new(datasource) }
  subject { BarclaysBikeCli::StationAdapter.new(stations: test_repository.all) }

  describe '#to_triples' do
    context 'given datasource' do
      it 'returns expected number of results' do
        results = subject.to_triples

        expect(results.size).to eq(2)
      end

      it 'produces triple of first station' do
        results = subject.to_triples

        expect(results.first).to eq([51.53005939, -0.120973687, 1])
      end

      it 'produces triple of second station' do
        results = subject.to_triples

        expect(results.last).to eq([51.50810309, -0.12602103, 2])
      end
    end
  end
end
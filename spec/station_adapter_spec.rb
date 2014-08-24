require 'spec_helper'

RSpec.describe BarclaysBikeCli::StationAdapter do
  let(:datasource) { TestDatasource.new }
  let(:test_repository) { BarclaysBikeCli::StationRepository.new(datasource) }
  subject { BarclaysBikeCli::StationAdapter.new(test_repository.all) }

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

    context 'given request with specific ids' do
      it 'returns expected number of results' do
        results = subject.to_triples(2)

        expect(results.size).to eq(1)
      end

      it 'produces triple of station id 2' do
        results = subject.to_triples(2)

        expect(results.first).to eq([51.50810309, -0.12602103, 2])
      end
    end
  end
end

require 'spec_helper'

RSpec.describe LondonBikeHireCli::Repository::StationRepo do
  let(:test_datasource) { TestDatasource.new }
  let(:adapter) { LondonBikeHireCli::Repository::StationStore.new(test_datasource.fetch) }
  before do
    LondonBikeHireCli::Repository::Repo.register(adapter)
  end
  subject { described_class.new }

  describe '#all' do
    context 'given feed_parser returns dataset' do
      it 'should return expected number of results' do
        results = subject.all

        expect(results.size).to eq(2)
      end
    end
  end

  describe '#find' do
    context 'given feed_parser returns dataset' do
      it 'should return expected number of results' do
        result = subject.find(1)

        expect(result).to be
      end

      it 'should return expected result' do
        result = subject.find(1)

        expect(result.name).to eq('test-station-1')
      end

      context 'given a request for an id that does not exist' do
        it 'should raise error' do
          expect do
            subject.find(99)
          end.to raise_error(KeyError)
        end
      end

      context 'given a request for more than one id' do
        xit 'should return expected number of results' do
          results = subject.find(1, 2)

          expect(results.size).to eq(2)
        end
      end
    end
  end

  describe '#query' do
    describe 'for stations by name' do
      let(:query) { LondonBikeHireCli::Queries::StationsByName.new('test-station-1') }

      context 'given feed_parser returns dataset' do
        it 'should return expected number of results' do
          results = subject.query(query)

          expect(results.size).to eq(1)
        end

        it 'should return expected result' do
          result = subject.query(query).first

          expect(result.name).to eq('test-station-1')
        end

        context 'given a request for an id that does not exist' do
          let(:query) { LondonBikeHireCli::Queries::StationsByName.new('foo') }

          it 'should not raise error' do
            expect do
              subject.query(query)
            end.not_to raise_error
          end

          it 'should return empty array' do
            expect(subject.query(query).size).to eq(0)
          end
        end
      end
    end

    describe 'for stations near location' do
      let(:point) { { lat: 51.50810309, long: -0.12602103 } }
      let(:query) { LondonBikeHireCli::Queries::StationsNear.new(point[:lat], point[:long], 5) }

      context 'given feed_parser returns dataset' do
        it 'should return expected number of results' do
          results = subject.query(query)

          expect(results.size).to eq(2)
        end

        it 'should return expected result' do
          result = subject.query(query).first

          expect(result.name).to eq('test-station-2')
        end
      end
    end
  end

  describe 'integration tests', vcr: { cassette_name: 'feed_xml' } do
    let(:test_datasource) { LondonBikeHireCli::FeedParser.new }

    describe '#find' do
      it 'should return expected number of results' do
        result = subject.find(777)

        expect(result).to be
      end

      it 'should return expected result' do
        result = subject.find(777)

        expect(result.name).to eq('Limburg Road, Clapham Junction')
      end
    end

    describe '#query' do
      let(:query) { LondonBikeHireCli::Queries::StationsByName.new('kings') }

      it 'should return expected number of results' do
        results = subject.query(query)

        expect(results.size).to eq(4)
      end

      it 'should return expected result' do
        results = subject.query(query)
        actual_ids = results.map(&:id)

        expect(actual_ids).to include(283, 594, 799, 836)
      end
    end

    describe '#all' do
      it 'should return expected number of results' do
        results = subject.all

        expect(results.size).to eq(789)
      end
    end
  end
end

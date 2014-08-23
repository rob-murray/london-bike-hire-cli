require 'spec_helper'

RSpec.describe BarclaysBikeCli::StationRepository do
  let(:datasource) { TestDatasource.new }
  subject { BarclaysBikeCli::StationRepository.new(datasource) }

  describe '#all' do
    context 'given feed_parser returns dataset' do
      it 'should return expected number of results' do
        results = subject.all

        expect(results.size).to eq(2)
      end
    end
  end

  describe '#find_by_id' do
    context 'given feed_parser returns dataset' do
      it 'should return expected number of results' do
        results = subject.find_by_id(1)

        expect(results.size).to eq(1)
      end

      it 'should return expected result' do
        result = subject.find_by_id(1).first

        expect(result.name).to eq('test-station-1')
      end

      context 'given a request for an id that does not exist' do
        it 'should raise error' do
          expect do
            subject.find_by_id(99)
          end.to raise_error
        end
      end

      context 'given a request for more than one id' do
        it 'should return expected number of results' do
          results = subject.find_by_id(1, 2)

          expect(results.size).to eq(2)
        end
      end
    end
  end

  describe '#find_by_name' do
    context 'given feed_parser returns dataset' do
      it 'should return expected number of results' do
        results = subject.find_by_name('test-station-1')

        expect(results.size).to eq(1)
      end

      it 'should return expected result' do
        result = subject.find_by_name('test-station-1').first

        expect(result.id).to eq(1)
      end

      context 'given a request for an id that does not exist' do
        it 'should not raise error' do
          expect do
            subject.find_by_name('foo')
          end.not_to raise_error
        end

        it 'should return empty array' do
          expect(subject.find_by_name('foo').size).to eq(0)
        end
      end
    end

    describe 'integration tests', vcr: { cassette_name: 'feed_xml' } do
      subject { BarclaysBikeCli::StationRepository.new(BarclaysBikeCli::FeedParser.new) }

      describe '#find_by_id' do
        it 'should return expected number of results' do
          results = subject.find_by_id(777)

          expect(results.size).to eq(1)
        end

        it 'should return expected result' do
          result = subject.find_by_id(777).first

          expect(result.name).to eq('Limburg Road, Clapham Common')
        end
      end

      describe '#find_by_name' do
        it 'should return expected number of results' do
          results = subject.find_by_name('kings')

          expect(results.size).to eq(3)
        end

        it 'should return expected result' do
          results = subject.find_by_name('kings')
          actual_ids = results.map(&:id)

          expect(actual_ids).to include(283, 439, 594)
        end
      end

      describe '#all' do
        it 'should return expected number of results' do
          results = subject.all

          expect(results.size).to eq(747)
        end
      end
    end
  end
end

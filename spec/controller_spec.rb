require 'spec_helper'

RSpec.describe LondonBikeHireCli::Controller do
  let(:repository) { double }
  let(:renderer) { double.as_null_object }
  subject { described_class.new(repository: repository, renderer: renderer) }

  describe '#all' do
    it 'should request stations from repository' do
      expect(repository).to receive(:all)

      subject.all
    end
  end

  describe '#find_by_id' do
    it 'should request station from repository' do
      expect(repository).to receive(:find).with(1)

      subject.find_by_id(1)
    end

    context 'given a string argument' do
      it 'should request station from repository' do
        expect(repository).to receive(:find).with(1)

        subject.find_by_id('1')
      end
    end

    context 'given repository raising not found error' do
      it 'does not raise_error' do
        allow(repository).to receive(:find).and_raise(LondonBikeHireCli::StationNotFoundError)

        expect do
          subject.find_by_id(1)
        end.not_to raise_error
      end
    end
  end

  describe '#where' do
    context 'given a request with name parameter' do
      it 'should request stations from repository with query' do
        expect(repository).to receive(:query) do |arg|
          expect(arg.search_term).to eq('kings')
        end

        subject.where(params: { name: 'kings' })
      end

      context 'given repository raising not found error' do
        it 'does not raise_error' do
          # TODO: change this
          allow(repository).to receive(:query).and_raise(LondonBikeHireCli::StationNotFoundError)

          expect do
            subject.where(params: { name: 'kings' })
          end.not_to raise_error
        end
      end
    end
  end

  describe '#nearest' do
    let(:geocoder) { double.as_null_object }
    let(:geocoded_point) { { lat: 51.5309584, long: -0.1215387 } }

    context 'given two nearest params' do
      let(:params) do
        { search_term: 'foo', id: 99 }
      end

      it 'does not process request' do
        expect(repository).not_to receive(:query)

        subject.nearest(params: params)
      end
    end

    context 'given a request with search_term parameter' do
      let(:search_term) { 'N19AE' }
      before do
        allow(repository).to receive(:find).and_return(double.as_null_object)
        allow(geocoder).to receive(:geocode).and_return(geocoded_point)
        allow(repository).to receive(:query)

        subject.geocoder = geocoder
      end

      it 'geocodes search_term via service' do
        expect(geocoder).to receive(:geocode).with(search_term).and_return(geocoded_point)

        subject.nearest(params: { search_term: search_term })
      end

      it 'requests stations from repository by query' do
        expect(repository).to receive(:query) do |arg|
          expect(arg.lat).to eq(geocoded_point[:lat])
          expect(arg.long).to eq(geocoded_point[:long])
          expect(arg.limit).to eq(LondonBikeHireCli::DEFAULT_SEARCH_LIMIT)
        end

        subject.nearest(params: { search_term: search_term })
      end

      context 'with invalid search' do
        let(:search_term) { '!' }
        before do
          allow(geocoder).to receive(:geocode).and_return(nil)
        end

        it 'does not request stations from repository' do
          expect(repository).not_to receive(:query)
        end
      end
    end

    context 'given a request with id parameter' do
      let(:search_id) { 1 }
      let(:station) { double('Station', id: 1, position: geocoded_point) }
      before do
        allow(repository).to receive(:find).and_return(station)
        allow(repository).to receive(:query)

        subject.geocoder = geocoder
      end

      it 'requests station from repository' do
        expect(repository).to receive(:find).with(search_id)

        subject.nearest(params: { id: search_id })
      end

      it 'requests stations from repository by query' do
        expect(repository).to receive(:query) do |arg|
          expect(arg.lat).to eq(geocoded_point[:lat])
          expect(arg.long).to eq(geocoded_point[:long])
          expect(arg.limit).to eq(LondonBikeHireCli::DEFAULT_SEARCH_LIMIT)
        end

        subject.nearest(params: { id: search_id })
      end

      context 'with invalid search' do
        let(:search_id) { 999 }

        it 'does not request stations from repository' do
          expect(repository).not_to receive(:all)
        end
      end
    end
  end
end

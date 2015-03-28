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
      expect(repository).to receive(:find_by_id).with(1)

      subject.find_by_id(1)
    end

    context 'given a string argument' do
      it 'should request station from repository' do
        expect(repository).to receive(:find_by_id).with(1)

        subject.find_by_id('1')
      end
    end

    context 'given repository raising not found error' do
      it 'does not raise_error' do
        allow(repository).to receive(:find_by_id).and_raise(LondonBikeHireCli::StationRepository::StationNotFound)

        expect do
          subject.find_by_id(1)
        end.not_to raise_error
      end
    end
  end

  describe '#where' do
    context 'given a request with name parameter' do
      it 'should request stations from repository' do
        expect(repository).to receive(:find_by_name).with('kings')

        subject.where(params: { name: 'kings' })
      end

      context 'given repository raising not found error' do
        it 'does not raise_error' do
          allow(repository).to receive(:find_by_name).and_raise(LondonBikeHireCli::StationRepository::StationNotFound)

          expect do
            subject.where(params: { name: 'kings' })
          end.not_to raise_error
        end
      end
    end
  end

  describe '#nearest' do
    let(:stations) { TestDatasource.new.fetch.values }
    let(:spatial_search) { double.as_null_object }
    let(:geocoder) { double.as_null_object }
    let(:geocoded_point) { { lat: 51.5309584, long: -0.1215387 } }

    context 'given two nearest params' do
      let(:params) do
        { search_term: 'foo', id: 99 }
      end

      it 'does not process request' do
        expect(repository).not_to receive(:all)

        subject.nearest(params: params)
      end
    end

    context 'given a request with search_term parameter' do
      let(:search_term) { 'N19AE' }
      before do
        allow(repository).to receive(:all).and_return(stations)
        allow(repository).to receive(:find_by_id).and_return(double.as_null_object)
        allow(geocoder).to receive(:geocode).and_return(geocoded_point)
        allow(spatial_search).to receive(:nearest).and_return([1])

        subject.geocoder = geocoder
        subject.spatial_service = spatial_search
      end

      it 'geocodes search_term via service' do
        expect(geocoder).to receive(:geocode).with(search_term).and_return(geocoded_point)

        subject.nearest(params: { search_term: search_term })
      end

      it 'requests all stations from repository' do
        expect(repository).to receive(:all).and_return(stations)

        subject.nearest(params: { search_term: search_term })
      end

      it 'passes all stations to spatial search' do
        subject.spatial_service = nil
        expect(LondonBikeHireCli::SpatialSearch).to receive(:new).and_return(spatial_search)

        subject.nearest(params: { search_term: search_term })
      end

      it 'requests nearest ids from geocoded point' do
        expect(spatial_search).to receive(:nearest).and_return([1])

        subject.nearest(params: { search_term: search_term })
      end

      it 'retreives stations matched by search' do
        expect(repository).to receive(:find_by_id).with(1)

        subject.nearest(params: { search_term: search_term })
      end

      context 'with invalid search' do
        let(:search_term) { '!' }
        before do
          allow(geocoder).to receive(:geocode).and_return(nil)
        end

        it 'does not request stations from repository' do
          expect(repository).not_to receive(:all)
        end
      end
    end

    context 'given a request with id parameter' do
      let(:search_id) { 1 }
      before do
        allow(repository).to receive(:all).and_return(stations)
        allow(repository).to receive(:find_by_id).and_return(double.as_null_object)
        allow(spatial_search).to receive(:nearest).and_return([1, 2])

        subject.geocoder = geocoder
        subject.spatial_service = spatial_search
      end

      it 'requests station from repository' do
        expect(repository).to receive(:find_by_id).with(search_id)

        subject.nearest(params: { id: search_id })
      end

      it 'requests all stations from repository' do
        expect(repository).to receive(:all).and_return(stations)

        subject.nearest(params: { id: search_id })
      end

      it 'passes all stations to spatial search' do
        subject.spatial_service = nil
        expect(LondonBikeHireCli::SpatialSearch).to receive(:new).and_return(spatial_search)

        subject.nearest(params: { id: search_id })
      end

      it 'requests nearest ids from geocoded point' do
        expect(spatial_search).to receive(:nearest).and_return([1])

        subject.nearest(params: { id: search_id })
      end

      it 'retreives stations matched by search' do
        expect(repository).to receive(:find_by_id).with(1)

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

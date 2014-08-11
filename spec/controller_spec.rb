require 'spec_helper'

RSpec.describe BarclaysBikeCli::Controller do
  let(:repository) { double }
  let(:renderer) { double.as_null_object }
  subject { BarclaysBikeCli::Controller.new(repository: repository, renderer: renderer) }

  describe '#find_by_id' do
    it 'should request station from repository' do
      expect(repository).to receive(:find_by_id).with(1)

      subject.find_by_id(id: 1)
    end

    context 'given a string argument' do
      it 'should request station from repository' do
        expect(repository).to receive(:find_by_id).with(1)

        subject.find_by_id(id: '1')
      end
    end

    context 'given repository raising not found error' do
      it 'does not raise_error' do
        allow(repository).to receive(:find_by_id).and_raise(BarclaysBikeCli::StationRepository::StationNotFound)

        expect do
          subject.find_by_id(id: 1)
        end.not_to raise_error
      end
    end
  end

  describe '#find_by_name' do
    it 'should request stations from repository' do
      expect(repository).to receive(:find_by_name).with('kings')

      subject.where(params: { name: 'kings' })
    end

    context 'given repository raising not found error' do
      it 'does not raise_error' do
        allow(repository).to receive(:find_by_name).and_raise(BarclaysBikeCli::StationRepository::StationNotFound)

        expect do
          subject.where(params: { name: 'kings' })
        end.not_to raise_error
      end
    end
  end
end

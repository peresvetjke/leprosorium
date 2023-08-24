require 'rails_helper'

RSpec.describe Array do
  describe 'indexes' do
    subject { array.indexes(element) }

    let(:array) { [1, 2, 3, 1] }
    let(:element) { 2 }

    it 'returns indexes' do
      is_expected.to eq([1])
    end

    context 'when several matches' do
      let(:array) { [2, 2, 3, 2, 2] }

      it { is_expected.to eq([0, 1, 3, 4]) }
    end

    context 'when no match' do
      let(:element) { 0 }

      it { is_expected.to eq([]) }
    end
  end

  describe 'list_indexes' do
    subject { array.list_indexes(list) }

    let(:array) { [1, 2, 3, 1, 2, 0, 1] }
    let(:list) { [1, 2] }

    it 'returns indexes' do
      is_expected.to eq([0, 3])
    end

    context 'when no match' do
      let(:list) { [1, 3] }

      it { is_expected.to eq([]) }
    end
  end
end

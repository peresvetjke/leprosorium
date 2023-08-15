require 'rails_helper'

RSpec.describe Stemmer::Natasha do
  subject { described_class.new.call(text) }

  let(:text) { %w[Исламского государства] }

  it 'returns stems', aggregate_failures: true do
    is_expected.to be_a(Hash)
    expect(subject['Исламского']).to eq('исламский')
    expect(subject['государства']).to eq('государство')
  end
end

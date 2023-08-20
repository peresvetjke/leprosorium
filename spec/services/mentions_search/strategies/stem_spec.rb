require 'rails_helper'

RSpec.describe MentionsSearch::Strategies::Stem do
  subject { described_class.new(leprosorium: leprosorium, text: text, stemmer: stemmer).find_mentions(entity) }

  let(:stemmer) { Stemmer::Natasha.new }
  let(:leprosorium) { Leprosorium.new(entities: entities, disclaimer_types: {}) }
  let(:entities) { [entity] }
  let(:entity) { { aliases: ['ИГИЛ', 'Исламское государство'], stemmable: true } }
  let(:text) { 'Исламского государства, текст, текст, ИГИЛ ИГИЛ' }
  let(:result) { ['Исламского государства', 'ИГИЛ'] }

  it { is_expected.to eq result }

  context 'with quotes' do
    let(:text) { '"Исламского государства", текст, текст, ИГИЛ ИГИЛ' }
    let(:result) { ['Исламского государства', 'ИГИЛ'] }

    it { is_expected.to eq result }
  end

  context 'when no match' do
    let(:text) { 'текст, текст' }
    let(:result) { %w[] }

    it { is_expected.to eq result }
  end
end

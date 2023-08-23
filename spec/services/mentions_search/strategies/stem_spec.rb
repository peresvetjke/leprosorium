require 'rails_helper'

RSpec.describe MentionsSearch::Strategies::Stem do
  include_context 'leprosorium'

  subject { described_class.new(text: text, stemmer: stemmer).find_mentions(entity) }

  let(:entity) { igil }
  let(:stemmer) { Stemmer::Natasha.new }
  let(:text) { 'Исламского государства, Исламское государство, текст, ИГИЛ ИГИЛ' }

  it 'returns mentions', aggregate_failures: true do
    is_expected.to all(be_a(Mention))
    expect(subject.map(&:as_json)).to match_array(
      [
        { 'match' => 'Исламского государства', 'from' => 0, 'to' => 21, 'entity_alias' => 'Исламское государство' },
        { 'match' => 'Исламское государство', 'from' => 24, 'to' => 44, 'entity_alias' => 'Исламское государство' },
        { 'match' => 'ИГИЛ', 'from' => 54, 'to' => 57, 'entity_alias' => 'ИГИЛ' },
        { 'match' => 'ИГИЛ', 'from' => 59, 'to' => 62, 'entity_alias' => 'ИГИЛ' }
      ]
    )
  end

  context 'with quotes' do
    let(:text) { '"Исламского государства", ИГИЛ' }

    it 'returns mentions', aggregate_failures: true do
      is_expected.to all(be_a(Mention))
      expect(subject.map(&:as_json)).to match_array(
        [
          { 'match' => 'Исламского государства', 'from' => 1, 'to' => 22, 'entity_alias' => 'Исламское государство' },
          { 'match' => 'ИГИЛ', 'from' => 26, 'to' => 29, 'entity_alias' => 'ИГИЛ' }
        ]
      )
    end
  end

  context 'when has intersecting aliases' do
    let(:entity) { venediktov }
    let(:text) { 'Венедиктов, Венедиктов, Венедиктова Алексея, Венедиктов Алексей' }
    let(:matches) { ['Венедиктов', 'Венедиктов', 'Венедиктова Алексея', 'Венедиктов Алексей'] }

    it 'returns mentions' do
      expect(subject.map(&:match)).to match_array(matches)
    end
  end

  context 'when no match' do
    let(:text) { 'текст, текст' }

    it { is_expected.to eq [] }
  end
end

require 'rails_helper'

RSpec.describe MentionsSearch::Strategies::Plain do
  include_context 'leprosorium'

  subject { described_class.new(text: text).find_mentions(zemfira) }

  let(:text) { 'Земфире, текст, текст, Земфира, Земфира' }

  it 'returns mentions', aggregate_failures: true do
    is_expected.to all(be_a(Mention))
    expect(subject.map(&:as_json)).to match_array(
      [
        { 'from' => 0, 'match' => 'Земфире', 'to' => 6, 'entity_alias' => 'Земфире' },
        { 'from' => 23, 'match' => 'Земфира', 'to' => 29, 'entity_alias' => 'Земфира' },
        { 'from' => 32, 'match' => 'Земфира', 'to' => 38, 'entity_alias' => 'Земфира' }
      ]
    )
  end

  context 'when no match' do
    let(:text) { 'текст, текст' }

    it { is_expected.to eq([]) }
  end
end

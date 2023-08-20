require 'rails_helper'

RSpec.describe MentionsSearch::Finder do
  let(:finder) { described_class.new(leprosorium: leprosorium, text: text, strategy_resolver: strategy_resolver) }
  let(:strategy_resolver) { MentionsSearch::StrategyResolver.new(leprosorium) }
  let(:resolver) { described_class.new(leprosorium) }
  let(:leprosorium) { Leprosorium.new(entities: entities, disclaimer_types: {}) }
  let(:entities) { [igil, venediktov] }
  let(:igil) { { aliases: ['ИГИЛ', 'Исламское государство'], stemmable: stemmable } }
  let(:venediktov) { { aliases: ['Алексей Венедиктов'], stemmable: stemmable } }
  let(:text) { 'Исламского государства, текст, текст, ИГИЛ ИГИЛ' }

  context 'when stemmable' do
    let(:stemmable) { true }

    it 'returns mentions' do
      expect(finder.call(igil)).to eq(['Исламского государства', 'ИГИЛ'])
    end

    it 'initializes only relevant strategies and not more than once' do
      expect(MentionsSearch::Strategies::Stem).to receive(:new).once.and_call_original
      expect(MentionsSearch::Strategies::Plain).not_to receive(:new)
      finder.call(igil)
      finder.call(venediktov)
    end
  end

  context 'when unstemmable' do
    let(:stemmable) { false }

    it 'returns mentions' do
      expect(finder.call(igil)).to eq(['ИГИЛ'])
    end

    it 'initializes only relevant strategies and not more than once' do
      expect(MentionsSearch::Strategies::Plain).to receive(:new).once.and_call_original
      expect(MentionsSearch::Strategies::Stem).not_to receive(:new)
      expect(finder.call(igil))
      expect(finder.call(venediktov))
    end
  end
end

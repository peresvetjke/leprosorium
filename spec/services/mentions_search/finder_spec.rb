require 'rails_helper'

RSpec.describe MentionsSearch::Finder do
  include_context 'leprosorium'

  let(:finder) { described_class.new(text: text, strategy_resolver: strategy_resolver) }
  let(:strategy_resolver) { MentionsSearch::StrategyResolver.new }
  let(:resolver) { described_class.new }

  context 'when stemmable' do
    let(:text) { 'Венедиктов, Венедиктов, Венедиктова Алексея, Венедиктов Алексей' }

    it 'returns mentions' do
      expect(finder.call(venediktov).map(&:match)).to eq(['Венедиктов', 'Венедиктов', 'Венедиктова Алексея', 'Венедиктов Алексей'])
    end

    it 'initializes only relevant strategies and not more than once' do
      expect(MentionsSearch::Strategies::Stem).to receive(:new).once.and_call_original
      expect(MentionsSearch::Strategies::Plain).not_to receive(:new)
      finder.call(igil)
      finder.call(igil)
    end
  end

  context 'when unstemmable' do
    let(:text) { 'Земфира Рамазанова, Земфира, Земфире' }

    it 'returns mentions' do
      expect(finder.call(zemfira).map(&:match)).to eq(['Земфира Рамазанова', 'Земфира', 'Земфире'])
    end

    it 'initializes only relevant strategies and not more than once' do
      expect(MentionsSearch::Strategies::Plain).to receive(:new).once.and_call_original
      expect(MentionsSearch::Strategies::Stem).not_to receive(:new)
      finder.call(zemfira)
      finder.call(zemfira)
    end
  end
end

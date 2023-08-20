require 'rails_helper'

RSpec.describe MentionsSearch::StrategyResolver do
  subject { resolver.call(entity) }

  let(:resolver) { described_class.new(leprosorium) }
  let(:leprosorium) { instance_double(Leprosorium) }
  let(:entity) { { aliases: ['Исламское государство', 'ИГИЛ'] } }

  before { allow(leprosorium).to receive(:entity_stemmable?).with(entity).and_return(stemmable) }

  context 'when stemmable' do
    let(:stemmable) { true }

    it { is_expected.to eq MentionsSearch::Strategies::Stem }
  end

  context 'when unstemmable' do
    let(:stemmable) { false }

    it { is_expected.to eq MentionsSearch::Strategies::Plain }
  end
end

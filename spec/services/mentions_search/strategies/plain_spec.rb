require 'rails_helper'

RSpec.describe MentionsSearch::Strategies::Plain do
  subject { described_class.new(leprosorium: leprosorium, text: text).find_mentions(entity) }

  let(:leprosorium) { Leprosorium.new(entities: [entity], disclaimer_types: {}) }
  let(:entity) { { aliases: %w[Монетка Монеточку Монеточке] } }
  let(:text) { 'Монеточке, текст, текст, Монетка, Монетка' }
  let(:result) { %w[Монеточке Монетка] }

  it { is_expected.to eq result }

  context 'when no match' do
    let(:text) { 'текст, текст' }
    let(:result) { %w[] }

    it { is_expected.to eq result }
  end
end

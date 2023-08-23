require 'rails_helper'

RSpec.describe DisclaimerMarker do
  include_context 'leprosorium'

  subject { described_class.new.call(text) }

  let(:entity) { zemfira }
  let(:text) { 'Земфира Рамазанова, текст, Земфира' }
  let(:result) { "Земфира Рамазанова (#{zemfira.disclaimer_text}), текст, Земфира" }

  it 'returns text with disclaimers' do
    is_expected.to eq(result)
  end

  context 'when already marked' do
    let(:text) { "Земфира Рамазанова, текст, Земфира (#{zemfira.disclaimer_text})" }
    let(:result) { text }

    it { is_expected.to eq(result) }
  end

  context 'with quotes' do
    let(:text) { '"Земфира" - это брэнд.' }
    let(:result) { "\"Земфира\" (#{zemfira.disclaimer_text}) - это брэнд." }

    it { is_expected.to eq result }
  end

  context 'when no mention' do
    let(:text) { 'Все будет хорошо.' }
    let(:result) { text }

    it { is_expected.to eq result }
  end
end

require 'rails_helper'

RSpec.describe DisclaimerMarker do
  include_context 'leprosorium'

  subject { described_class.new.call(text) }

  let(:text) { 'Земфира Рамазанова, текст, Земфира' }
  # let(:mentions) { ['Земфира Рамазанова', 'Земфира'] }
  # let(:disclaimer_types) { { inoagentka: disclaimer } }
  # let(:disclaimer) { 'признана иностранным агентом в РФ' }
  let(:result) { "Земфира Рамазанова (#{zemfira.disclaimer_text}), текст, Земфира" }

  # before { allow(finder).to receive(:call).with(entity).and_return(mentions) }

  it 'returns text with disclaimers' do
    is_expected.to eq(result)
  end
  # context 'when not stammable' do
  #   let(:leprosorium) { build(:leprosorium, disclaimer_types: disclaimer_types, entities: entities) }
  #   let(:disclaimer_types) { { inoagentka: disclaimer } }
  #   let(:disclaimer) { 'признана иностранным агентом в РФ' }
  #   let(:entities) do
  #     [
  #       {
  #         disclaimer_type: :inoagentka,
  #         aliases: ['Земфира', 'Земфирой', 'Земфире', 'Земфира Рамазанова', 'Земфирой Рамазановой', 'Земфире Рамазановой'],
  #         stemmable: false
  #       }
  #     ]
  #   end
  #   let(:text) { 'Земфира -  одна из наиболее известных российский музыкантов нашего времени.' }
  #   let(:result) { "Земфира (#{disclaimer}) -  одна из наиболее известных российский музыкантов нашего времени." }

  #   it { is_expected.to eq result }

  #   context 'when already marked' do
  #     let(:text) do
  #       "'Земфире поклонялись и поклоняются многие', - без лишней скромности сказала Земфира Рамазанова (#{disclaimer}) намедни."
  #     end
  #     let(:result) { text }

  #     it { is_expected.to eq result }
  #   end

  #   context 'with quotes' do
  #     let(:text) { '"Земфира" - это брэнд.' }
  #     let(:result) { "\"Земфира\" (#{disclaimer}) - это брэнд." }

  #     it { is_expected.to eq result }
  #   end

  #   context 'when no mention' do
  #     let(:text) { 'Все будет хорошо.' }
  #     let(:result) { text }

  #     it { is_expected.to eq result }
  #   end
  # end

  # context 'when stammable' do
  #   let(:leprosorium) { build(:leprosorium, disclaimer_types: disclaimer_types, entities: entities) }
  #   let(:disclaimer_types) { { terrorist: disclaimer } }
  #   let(:disclaimer) { 'организация признана террористической в РФ' }
  #   let(:entities) do
  #     [
  #       {
  #         disclaimer_type: :terrorist,
  #         aliases: ['ИГИЛ', 'Исламское государство'],
  #         stemmable: true
  #       }
  #     ]
  #   end
  #   let(:text) { 'Новые завления Исламского государства потрясли мир. ИГИЛ не дремлет.' }
  #   let(:result) { "Новые завления Исламского государства (#{disclaimer}) потрясли мир. ИГИЛ не дремлет." }

  #   it { is_expected.to eq result }

  #   context 'when already marked' do
  #     let(:text) { "Новые завления Исламского государства потрясли мир. ИГИЛ (#{disclaimer}) не дремлет." }
  #     let(:result) { text }

  #     it { is_expected.to eq result }
  #   end

  #   context 'with quotes' do
  #     let(:text) { 'Новые завления "Исламского государства" потрясли мир. ИГИЛ не дремлет.' }
  #     let(:result) { "Новые завления \"Исламского государства\" (#{disclaimer}) потрясли мир. ИГИЛ не дремлет." }

  #     it { is_expected.to eq result }
  #   end
  # end
end

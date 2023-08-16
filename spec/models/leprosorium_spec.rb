require 'rails_helper'

RSpec.describe Leprosorium do
  let(:leprosorium) { build(:leprosorium, disclaimer_types: disclaimer_types, entities: entities) }
  let(:disclaimer_types) do
    { terrorist: 'организация признана террористической в РФ', inoagentka: 'признана иностранным агентом в РФ'}
  end
  let(:entities) { [igil, zemfira] }
  let(:igil) do
    {
      disclaimer_type: :terrorist,
      aliases: ['ИГИЛ', 'Исламское государство'],
      stemmable: true
    }
  end
  let(:zemfira) do
    {
      disclaimer_type: :inoagentka,
      aliases: %w[Земфира Земфирой Земфире Земфиры],
      stemmable: false
    }
  end

  describe '#entities' do
    it { expect(leprosorium.entities).to eq(entities) }
  end

  describe '#disclaimer_types' do
    it { expect(leprosorium.disclaimer_types).to eq(disclaimer_types) }
  end

  describe '#disclaimer', aggregate_failures: true do
    it { expect(leprosorium.disclaimer(igil)).to eq(disclaimer_types[:terrorist]) }
    it { expect(leprosorium.disclaimer(zemfira)).to eq(disclaimer_types[:inoagentka]) }
  end

  describe '#stemmable_aliases' do
    it { expect(leprosorium.stemmable_aliases).to eq(['ИГИЛ', 'Исламское государство']) }
  end

  describe '#entity_aliases' do
    it { expect(leprosorium.entity_aliases(zemfira).sort).to eq(%w[Земфира Земфирой Земфире Земфиры].sort) }
  end

  describe '#entity_stemmable?', aggregate_failures: true do
    it { expect(leprosorium.entity_stemmable?(zemfira)).to eq(false) }
    it { expect(leprosorium.entity_stemmable?(igil)).to eq(true) }
  end
end

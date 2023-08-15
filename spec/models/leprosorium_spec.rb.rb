require 'rails_helper'

RSpec.describe Leprosorium do
  let(:leprosorium) { build(:leprosorium, disclaimer_types: disclaimer_types, entities: entities) }
  let(:disclaimer_types) { { terrorist: disclaimer } }
  let(:disclaimer) { 'организация признана террористической в РФ' }
  let(:entities) do
    [
      {
        disclaimer_type: :terrorist,
        aliases: ['ИГИЛ', 'Исламское государство'],
        stemmable: true
      }
    ]
  end

  describe '#entities' do
    it { expect(leprosorium.entities).to eq entities }
  end

  describe '#disclaimer_types' do
    it { expect(leprosorium.disclaimer_types).to eq disclaimer_types }
  end

  describe '#disclaimer' do
    it { expect(leprosorium.disclaimer('ИГИЛ')).to eq disclaimer }
  end
end

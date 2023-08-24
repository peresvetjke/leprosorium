require 'rails_helper'

RSpec.describe Leprosorium do
  describe 'entities' do
    let(:entities) do
      [
        {
          id: 1,
          disclaimer_id: 1,
          aliases: ['ИГИЛ', 'Исламское государство'],
          stemmable: true
        },
        {
          id: 2,
          disclaimer_id: 2,
          aliases: ['Земфира', 'Земфире', 'Земфира Рамазанова', 'Земфире Рамазановой'],
          stemmable: false
        }
      ]
    end

    it 'caches records' do
      expect(described_class.entities).to eq([])
      described_class.entities = entities
      expect(described_class.entities.size).to eq(2)
      expect(described_class.entities).to all(be_a(Entity))
    end
  end

  describe 'disclaimers' do
    let(:disclaimers) do
      [
        {
          id: 1,
          text: 'организация признана террористической в РФ'
        },
        {
          id: 2,
          text: 'признана иностранным агентом в РФ'
        }
      ]
    end

    it 'caches records' do
      expect(described_class.disclaimers).to eq([])
      described_class.disclaimers = disclaimers
      expect(described_class.disclaimers.size).to eq(2)
      expect(described_class.disclaimers).to all(be_a(Disclaimer))
    end
  end
end

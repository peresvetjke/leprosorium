require 'rails_helper'

RSpec.shared_context 'leprosorium' do
  let(:entities) { [igil, zemfira, venediktov] }
  let(:disclaimers) do
    [
      Disclaimer.new(id: 1, text: 'организация признана террористической в РФ'),
      Disclaimer.new(id: 2, text: 'признана иностранным агентом в РФ'),
      Disclaimer.new(id: 3, text: 'признан иностранным агентом в РФ')
    ]
  end
  let(:igil) do
    Entity.new(
      id: 1,
      disclaimer_id: 1,
      aliases: ['ИГИЛ', 'Исламское государство'],
      stemmable: true
    )
  end
  let(:zemfira) do
    Entity.new(
      id: 2,
      disclaimer_id: 2,
      aliases: ['Земфира', 'Земфире', 'Земфира Рамазанова', 'Земфире Рамазановой'],
      stemmable: false
    )
  end
  let(:venediktov) do
    Entity.new(
      id: 2,
      disclaimer_id: 3,
      aliases: ['Венедиктов', 'Венедиктов Алексей', 'Алексей Венедиктов'],
      stemmable: true
    )
  end

  before do
    allow(Leprosorium).to receive(:entities).and_return(entities)
    allow(Leprosorium).to receive(:disclaimers).and_return(disclaimers)
  end
end

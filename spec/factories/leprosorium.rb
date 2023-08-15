FactoryBot.define do
  factory :leprosorium do
    disclaimer_types { { terrorist: 'организация признана террористической в РФ' } }
    entities do
      [
        {
          type: :terrorist,
          aliases: ['ИГИЛ', 'Исламское государство'],
          stemmable: true
        }
      ]
    end

    initialize_with { new(entities: entities, disclaimer_types: disclaimer_types) }
  end
end

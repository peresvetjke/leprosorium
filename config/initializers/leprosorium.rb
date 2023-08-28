# frozen_string_literal: true

require File.expand_path('app/models/leprosorium')

# Dummy leprosorium config.
unless Rails.env.test?
  entities = [
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

  disclaimers = [
    {
      id: 1,
      text: 'организация признана террористической в РФ'
    },
    {
      id: 2,
      text: 'признана иностранным агентом в РФ'
    }
  ]

  Leprosorium.entities = entities
  Leprosorium.disclaimers = disclaimers
end

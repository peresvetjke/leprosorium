module LeprosoriumHelper
  def default_text_value
    'Земфира Рамазанова еще не комментировала заявления Исламского государства.'
  end

  def dummy_leprosorium
    <<~HEREDOC
      {
        entities: [
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
        ],
        disclaimers: [
          {
            id: 1,
            text: 'организация признана террористической в РФ'
          },
          {
            id: 2,
            text: 'признана иностранным агентом в РФ'
          }
        ]
      }
    HEREDOC
  end
end

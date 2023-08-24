module LeprosoriumHelper
  def default_text_value
    'Земфира Рамазанова еще не комментировала заявления Исламского государства.'
  end

  def leprosorium_config
    entities = Leprosorium.entities.as_json
    disclaimers = Leprosorium.disclaimers.as_json
    {
      entities: entities,
      disclaimers: disclaimers
    }
  end
end

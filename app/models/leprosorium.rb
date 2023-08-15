# frozen_string_literal: true

class Leprosorium
  attr_reader :entities, :disclaimer_types

  def initialize(entities:, disclaimer_types:)
    @entities = entities
    @disclaimer_types = disclaimer_types
  end

  # TODO: refactor. Probably we don't want to revert hash every time.
  def disclaimer(entity_alias)
    entity = entities.find { |e| e[:aliases].include?(entity_alias) }
    disclaimer_type = entity[:disclaimer_type]
    disclaimer_types[disclaimer_type]
  end
end

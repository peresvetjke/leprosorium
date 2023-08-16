# frozen_string_literal: true

class Leprosorium
  attr_reader :entities, :disclaimer_types

  # @param entities [Hash]
  # @param disclaimer_types [Hash]
  def initialize(entities:, disclaimer_types:)
    @entities = entities
    @disclaimer_types = disclaimer_types
  end

  # TODO: refactor. Probably we don't want to revert hash every time.
  # @param entity_alias [String]
  # @return String
  def disclaimer(entity)
    disclaimer_type = entity[:disclaimer_type]
    disclaimer_types[disclaimer_type]
  end

  # @return [Array<String>]
  def stemmable_aliases
    stemmable_entities = entities.select { |e| e[:stemmable] }
    stemmable_entities.map { |e| e[:aliases] }.flatten
  end

  def entity_aliases(entity)
    entity[:aliases]
  end

  def entity_stemmable?(entity)
    entity[:stemmable]
  end
end

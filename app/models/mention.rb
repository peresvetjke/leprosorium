# frozen_string_literal: true

class Mention
  attr_reader :from, :to, :match, :entity_alias

  # @param from [Integer]
  # @param to [Integer]
  # @param match [String]
  # @param entity_alias [String]
  def initialize(from:, to:, match:, entity_alias:)
    @from = from
    @to = to
    @match = match
    @entity_alias = entity_alias
  end
end

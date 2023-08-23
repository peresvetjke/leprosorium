# frozen_string_literal: true

class Mention
  attr_reader :from, :to, :match, :entity_alias

  def initialize(from:, to:, match:, entity_alias:)
    @from = from
    @to = to
    @match = match
    @entity_alias = entity_alias
  end
end

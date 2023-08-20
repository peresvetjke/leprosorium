# frozen_string_literal: true

class Entity
  attr_reader :id, :disclaimer_id, :aliases, :stemmable

  alias stemmable? stemmable

  def self.all

  end

  def initialize(id:, disclaimer_id:, aliases:, stemmable:)
    @id = id
    @disclaimer_id = disclaimer_id
    @aliases = aliases
    @stemmable = stemmable
  end
end

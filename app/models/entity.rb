# frozen_string_literal: true

class Entity
  attr_reader :id, :disclaimer_id, :aliases, :stemmable

  alias stemmable? stemmable

  class << self
    def all
      Leprosorium.entities
    end

    def find(id)
      all.find { |e| e.id == id }
    end
  end

  def initialize(id:, disclaimer_id:, aliases:, stemmable:)
    @id = id
    @disclaimer_id = disclaimer_id
    @aliases = aliases
    @stemmable = stemmable
  end

  def disclaimer
    Disclaimer.find(disclaimer_id)
  end

  def disclaimer_text
    disclaimer.text
  end
end

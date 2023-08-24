# frozen_string_literal: true

class Entity
  attr_reader :id, :disclaimer_id, :aliases, :stemmable

  alias stemmable? stemmable

  class << self
    # @return [Array<Entity>]
    def all
      Leprosorium.entities
    end

    # @param id [Integer]
    # @return [Entity, NilClass]
    def find(id)
      all.find { |e| e.id == id }
    end
  end

  # @param id [Integer]
  # @param disclaimer_id [Integer]
  # @param aliases [Array<String>]
  # @param stemmable [Boolean]
  def initialize(id:, disclaimer_id:, aliases:, stemmable:)
    @id = id.to_i
    @disclaimer_id = disclaimer_id.to_i
    @aliases = aliases
    @stemmable = stemmable
  end

  # @return [Disclaimer]
  def disclaimer
    Disclaimer.find(disclaimer_id)
  end

  # @return [String]
  def disclaimer_text
    disclaimer.text
  end
end

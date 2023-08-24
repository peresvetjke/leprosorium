# frozen_string_literal: true

class Disclaimer
  attr_reader :id, :text

  class << self
    # @return [Array<Disclaimer>]
    def all
      Leprosorium.disclaimers
    end

    # @param id [Integer]
    # @return [Entity, NilClass]
    def find(id)
      all.find { |d| d.id == id }
    end
  end

  # @param id [String]
  # @param text [String]
  def initialize(id:, text:)
    @id = id.to_i
    @text = text
  end
end

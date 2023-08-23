# frozen_string_literal: true

class Disclaimer
  attr_reader :id, :text

  class << self
    def all
      Leprosorium.disclaimers
    end

    def find(id)
      all.find { |d| d.id == id }
    end
  end

  def initialize(id:, text:)
    @id = id
    @text = text
  end
end

# frozen_string_literal: true

class DislaimerType
  attr_reader :id, :type, :text

  def initialize(id:, type:, text:)
    @type = type
    @text = text
  end
end

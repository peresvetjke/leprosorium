# frozen_string_literal: true

class SymbolsConfig
  attr_reader :letters, :space, :quotes

  def initialize(params = {})
    defaults = YAML.load_file("#{Rails.root}/config/symbols.yml").symbolize_keys
    config = defaults.merge(params)

    @letters = config[:letters]
    @space = config[:space]
    @quotes = config[:quotes]
  end
end

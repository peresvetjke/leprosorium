# frozen_string_literal: true

require 'pycall'

module Stemmer
  class Base
    def initialize(symbols_config = SymbolsConfig.new)
      @symbols_config = symbols_config
      initialize_stemmer
    end

    # @param input [Array<String>]
    # @return [Hash{String => String}]
    def call(input)
      text = input.join(' ').scan(/[#{letters}]+/i).join(' ')
      @stemmer.stem(text).to_h
    end

    private

    attr_reader :symbols_config

    delegate :letters, to: :symbols_config

    def initialize_stemmer
      path = File.expand_path(File.join('lib', 'python'))
      PyCall.sys.path.append(path)
      @stemmer = PyCall.import_module("#{self.class.name.demodulize.downcase}_stemmer")
    end
  end
end

# frozen_string_literal: true

require 'pycall'

module Stemmer
  class Natasha
    def initialize
      path = File.expand_path('lib')
      PyCall.sys.path.append(path)
      @stemmer = PyCall.import_module('stemmer')
    end

    # @param input [Array<String>]
    # @return [Hash{String => String}]
    def call(input)
      text = input.join('; ')
      @stemmer.stem(text).to_h
    end
  end
end

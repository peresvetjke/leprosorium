# frozen_string_literal: true

module MentionsSearch
  class Finder
    def initialize(text:, strategy_resolver: nil, symbols_config: nil)
      @text = text
      @strategy_resolver = strategy_resolver || MentionsSearch::StrategyResolver.new
      @symbols_config = symbols_config || SymbolsConfig.new
      @strategies = []
    end

    def call(entity)
      strategy = find_or_initialize_strategy(entity)
      strategy.find_mentions(entity)
    end

    private

    attr_reader :strategies, :symbols_config, :text

    def find_or_initialize_strategy(entity)
      strategy_klass = @strategy_resolver.call(entity)
      strategies.find { |p| p.is_a?(strategy_klass) } || initialize_strategy(strategy_klass)
    end

    def initialize_strategy(strategy_klass)
      strategy = strategy_klass.new(text: text, symbols_config: symbols_config)
      strategies.append(strategy)
      strategy
    end
  end
end

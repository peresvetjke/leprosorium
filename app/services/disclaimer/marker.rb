# frozen_string_literal: true

module Disclaimer
  class Marker
    def initialize(leprosorium:, symbols_config: nil, strategy_resolver: nil)
      @leprosorium = leprosorium
      @symbols_config = symbols_config || SymbolsConfig.new
      @strategy_resolver = strategy_resolver || MentionsSearch::StrategyResolver.new(leprosorium)
    end

    def call(text)
      finder = build_finder(text)
      entities.reduce(text).reduce(text) { |result, entity| markup_entity(finder, result, entity) }
    end

    private

    attr_reader :leprosorium, :symbols_config, :strategy_resolver

    delegate :entities, :disclaimer, to: :leprosorium

    def build_finder(text)
      options = {
        leprosorium: leprosorium,
        text: text,
        strategy_resolver: strategy_resolver,
        symbols_config: symbols_config
      }
      MentionsSearch::Finder.new(**options)
    end

    # @param text [String]
    # @param entity [Hash]
    # @return [String]
    def markup_entity(finder, text, entity)
      mentions = finder.call(entity)
      return text if mentions.blank?# || mentions.any? { |m| text.match?(marked_mention_regexp(m, disclaimer(entity))) }

      m = text.match(mention_regexp(mentions.first))
      text.sub(m[0], mention_with_disclaimer(m[0], entity))
    end

    # @param mention [String]
    # @param entity [Hash]
    # @return [String]
    def mention_with_disclaimer(mention, entity)
      "#{mention} (#{disclaimer(entity)})"
    end
  end
end

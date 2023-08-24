# frozen_string_literal: true

class DisclaimerMarker
  # @param symbols_config [SymbolsConfig]
  # @param strategy_resolver [Object]
  def initialize(symbols_config: nil, strategy_resolver: nil)
    @symbols_config = symbols_config || SymbolsConfig.new
    @strategy_resolver = strategy_resolver || MentionsSearch::StrategyResolver.new
  end

  # @param text [String]
  # @return [String]
  def call(text)
    finder = build_finder(text)
    Entity.all.reduce(text) { |result, entity| markup_entity(finder, result, entity) }
  end

  private

  attr_reader :symbols_config, :strategy_resolver

  delegate :quotes, to: :symbols_config

  # @param text [String]
  # @return [MentionsSearch::Finder]
  def build_finder(text)
    options = {
      text: text,
      strategy_resolver: strategy_resolver,
      symbols_config: symbols_config
    }
    MentionsSearch::Finder.new(**options)
  end

  # @param finder [MentionsSearch::Finder]
  # @param text [String]
  # @param entity [Entity]
  # @return [String]
  def markup_entity(finder, text, entity)
    mentions = finder.call(entity)
    matches = mentions.map(&:match)
    return text if matches.blank? || matches.any? { |m| text.match?(marked_mention_regexp(m, entity.disclaimer_text)) }

    m = text.match(mention_regexp(matches.first))
    text.sub(m[0], mention_with_disclaimer(m[0], entity))
  end

  # @param mention [String]
  # @param entity [Entity]
  # @return [String]
  def mention_with_disclaimer(mention, entity)
    "#{mention} (#{entity.disclaimer_text})"
  end

  # @param mention [String]
  # @return [Regexp]
  def mention_regexp(mention)
    /([#{quotes}])?(#{mention})([#{quotes}])?/
  end

  # @param mention [String]
  # @param disclaimer [String]
  # @return [Regexp]
  def marked_mention_regexp(mention, disclaimer)
    /#{mention_regexp(mention)} \(#{disclaimer}\)/
  end
end

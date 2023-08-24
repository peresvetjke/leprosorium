# frozen_string_literal: true

module MentionsSearch
  module Strategies
    class Base
      # @param text [Text]
      # @param symbols_config [SymbolsConfig]
      def initialize(text:, symbols_config: SymbolsConfig.new)
        @text = text
        @symbols_config = symbols_config
      end

      # @param entity [Entity]
      # @return [Array<Mention>]
      def find_mentions(entity)
        mentions = find_entity_mentions(entity)
        filter_instersections_by_length(mentions).sort_by(&:from)
      end

      private

      attr_reader :text, :symbols_config

      # @param [Entity]
      # @return [Array<Mention>]
      def find_entity_mentions(entity)
        entity.aliases.map { |entity_alias| find_alias_mentions(entity_alias) }.flatten
      end

      # @param entity_alias [String]
      # @return [Array<Mention>]
      def find_alias_mentions(_entity_alias)
        raise NotImplementedError 'Not implemented for abstract class'
      end

      # @param from [Integer]
      # @param to [Integer]
      # @param entity_alias [String]
      # @return [Mention]
      def build_mention(from:, to:, entity_alias:)
        Mention.new(from: from, to: to, match: text[from..to], entity_alias: entity_alias)
      end

      def filter_instersections_by_length(mentions)
        mentions.group_by(&:from).values.map do |intersections|
          intersections.max_by { |m| m.match.length }
        end
      end
    end
  end
end

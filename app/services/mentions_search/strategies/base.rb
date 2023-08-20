# frozen_string_literal: true

module MentionsSearch
  module Strategies
    class Base
      # @param leprosorium [Leprosorium]
      # @param text [Text]
      def initialize(leprosorium:, text:, symbols_config: SymbolsConfig.new)
        @leprosorium = leprosorium
        @text = text
        @symbols_config = symbols_config
      end

      # @param entity [Hash]
      # @return [Array<String>]
      def find_mentions(entity)
        mentions = entity_aliases(entity).map { |entity_alias| find_mention(entity_alias) }.compact
        mentions.sort_by { |mention| text.index(mention) }
      end

      private

      attr_reader :leprosorium, :text, :symbols

      delegate :entity_aliases, to: :leprosorium

      # @param entity_alias [String]
      # @return [String, NilClass]
      def find_mention(_entity_alias)
        raise NotImplementedError 'Not implemented for abstract class'
      end
    end
  end
end

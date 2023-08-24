# frozen_string_literal: true

module MentionsSearch
  module Strategies
    class Stem < Base
      # @param options [Hash]
      def initialize(options)
        super(**options.except(:stemmer))
        @stemmer = options[:stemmer] || Stemmer::Pymorphy.new
      end

      private

      delegate :letters, :space, :quotes, to: :symbols_config

      attr_reader :symbols_config

      # @param entity_alias [String]
      # @return [Array<Mention>]
      def find_alias_mentions(entity_alias)
        phrase_match_positions(entity_alias).map { |i| build_mention_by_phrase_index(entity_alias, i) }
      end

      # @param entity_alias [String]
      # @return [Array<Integer]
      def phrase_match_positions(entity_alias)
        stemmed_text.list_indexes(stemmed_alias(entity_alias))
      end

      # @param entity_alias [String]
      # @param phrase_index [Integer]
      # @return [Mention]
      def build_mention_by_phrase_index(entity_alias, phrase_index)
        from = phrase_index.zero? ? 0 : splitted_text[0..(phrase_index - 1)].join.length
        to = from + match_length(entity_alias, phrase_index) - 1
        build_mention(from: from, to: to, entity_alias: entity_alias)
      end

      # @param entity_alias [String]
      # @param phrase_index [Integer]
      # @return [Integer]
      def match_length(entity_alias, phrase_index)
        splitted_text[phrase_index..(phrase_index + stemmed_alias(entity_alias).size - 1)].join.length
      end

      # @param entity_alias [String]
      # @return [Array<String>]
      def stemmed_alias(entity_alias)
        splitted_alias = split(entity_alias)
        stem(splitted_alias)
      end

      # @return [Hash]
      def stems
        @stems ||= begin
          stemmable_aliases = Entity.all.select(&:stemmable?).map(&:aliases).flatten
          @stemmer.call(stemmable_aliases.append(text))
        end
      end

      # @return [Array<String>]
      def stemmed_text
        @stemmed_text ||= stem(splitted_text)
      end

      # @param text [String]
      # @return [Array<String>]
      def stem(text)
        text.map { |w| stems[w] || w }
      end

      # @return [Array<String>]
      def splitted_text
        @splitted_text ||= split(text)
      end

      # @return [Array<String>]
      def split(text)
        text.scan(/[#{letters}]+|[^#{letters}]|#{space}+/i)
      end
    end
  end
end

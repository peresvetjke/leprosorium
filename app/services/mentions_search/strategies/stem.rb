# frozen_string_literal: true

module MentionsSearch
  module Strategies
    class Stem < Base
      def initialize(options)
        super(**options.except(:stemmer))
        @stemmer = options[:stemmer] || Stemmer::Natasha.new
      end

      private

      delegate :letters, :space, :quotes, to: :symbols_config

      attr_reader :symbols_config

      def find_alias_mentions!(entity_alias)
        mentions = []
        splitted_alias = split(entity_alias)
        alias_words_count = splitted_alias.size
        stemmed_alias = splitted_alias.map { |w| stems[w] || w }
        stemmed_text.each_cons(alias_words_count).with_index do |stemmed_text_part, i|
          next unless stemmed_text_part == stemmed_alias

          match_length = splitted_text[i..(i + alias_words_count - 1)].join.length
          from = i.zero? ? 0 : splitted_text[0..(i - 1)].join.length
          to = from + match_length - 1

          mentions << build_mention(from: from, to: to, entity_alias: entity_alias)
        end
        mentions
      end

      def stems
        @stems ||= begin
          stemmable_aliases = Leprosorium.entities.select(&:stemmable?).map(&:aliases).flatten
          @stemmer.call(stemmable_aliases.append(text))
        end
      end

      def stemmed_text
        @stemmed_text ||= splitted_text.map do |w|
          word = w.delete(quotes)
          stems[word] || word
        end
      end

      def splitted_text
        @splitted_text ||= split(text)
      end

      def split(text)
        text.scan(/[#{letters}]+|[^#{letters}]|#{space}+/i)
      end
    end
  end
end

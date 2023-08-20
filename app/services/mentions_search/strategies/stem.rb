# frozen_string_literal: true

module MentionsSearch
  module Strategies
    class Stem < Base
      def initialize(options)
        super(**options.except(:stemmer))
        @stemmer = options[:stemmer] || Stemmer::Natasha.new
      end

      private

      delegate :stemmable_aliases, to: :leprosorium
      delegate :letters, :space, :quotes, to: :symbols_config

      attr_reader :symbols_config

      def find_mention(entity_alias)
        alias_size = entity_alias.split.size
        stemmed_alias = entity_alias.split.map { |w| stems[w] }
        stemmed_text.each_cons(alias_size).with_index do |stemmed_text_part, i|
          return splitted_text[i..(i + alias_size - 1)].join(' ') if stemmed_text_part == stemmed_alias
        end
        nil
      end

      def stems
        @stems ||= @stemmer.call(stemmable_aliases.append(text))
      end

      def stemmed_text
        @stemmed_text ||= splitted_text.map do |w|
          word = w.delete(quotes)
          stems[word] || word
        end
      end

      def splitted_text
        @splitted_text ||= text.scan(/[#{letters}]+|[^#{letters}#{space}]+/i)
      end
    end
  end
end

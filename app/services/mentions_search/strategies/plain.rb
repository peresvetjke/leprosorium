# frozen_string_literal: true

module MentionsSearch
  module Strategies
    class Plain < Base
      # @param entity_alias [String]
      # @return [Array<Mention>]
      def find_alias_mentions(entity_alias)
        mentions = []
        offset = 0

        while (from = text.index(entity_alias, offset))
          to = from + entity_alias.length - 1
          mentions << build_mention(from: from, to: to, entity_alias: entity_alias)
          offset = to
        end

        mentions
      end
    end
  end
end

# frozen_string_literal: true

module MentionsSearch
  module Strategies
    class Plain < Base
      def find_mention(entity_alias)
        text[entity_alias]
      end
    end
  end
end

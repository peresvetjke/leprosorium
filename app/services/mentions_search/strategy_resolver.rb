# frozen_string_literal: true

module MentionsSearch
  class StrategyResolver
    def call(entity)
      entity.stemmable? ? MentionsSearch::Strategies::Stem : MentionsSearch::Strategies::Plain
    end
  end
end

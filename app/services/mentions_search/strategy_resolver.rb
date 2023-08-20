# frozen_string_literal: true

module MentionsSearch
  class StrategyResolver
    def initialize(leprosorium)
      @leprosorium = leprosorium
    end

    def call(entity)
      entity_stemmable?(entity) ? MentionsSearch::Strategies::Stem : MentionsSearch::Strategies::Plain
    end

    private

    delegate :entities, :entity_stemmable?, to: :leprosorium

    attr_reader :leprosorium
  end
end

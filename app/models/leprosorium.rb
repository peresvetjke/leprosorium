# frozen_string_literal: true

class Leprosorium
  attr_reader :entities, :disclaimer_types

  class << self
    def entities=(input)
      Rails.cache.write(:entities, input)
    end

    def entities
      cache = Rails.cache.fetch(:entities) { [] }
      cache.map do |params|
        Entity.new(
          id: params[:id],
          disclaimer_id: params[:disclaimer_id],
          aliases: params[:aliases],
          stemmable: params[:stemmable]
        )
      end
    end

    def disclaimers=(input)
      Rails.cache.write(:disclaimers, input)
    end

    def disclaimers
      cache = Rails.cache.fetch(:disclaimers) { [] }
      cache.map do |params|
        Disclaimer.new(
          id: params[:id],
          text: params[:text]
        )
      end
    end
  end
end

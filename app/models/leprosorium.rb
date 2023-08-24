# frozen_string_literal: true

class Leprosorium
  attr_reader :entities, :disclaimer_types

  class << self
    # @param input [Array<Hash>]
    # @return [Boolean]
    def entities=(input)
      Rails.cache.write(:entities, input)
    end

    # @return [Array<Entities>]
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

    # @param [Array<Disclaimer>]
    # @return [Boolean]
    def disclaimers=(input)
      Rails.cache.write(:disclaimers, input)
    end

    # @return [Array<Disclaimer>]
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

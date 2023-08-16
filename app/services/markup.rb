class Markup
  QUOTES = "'\"`".freeze

  delegate :stemmable_aliases, :disclaimer, :entities, :entity_aliases, :entity_stemmable?, to: :leprosorium

  def initialize(leprosorium:, stemmer: ::Stemmer::Natasha.new)
    @leprosorium = leprosorium
    @stemmer = stemmer
    @stems = {}
  end

  # @param text [String]
  # @return [String]
  def call(text)
    get_stems(text)
    stem_text(text)
    markup_text(text)
  end

  private

  attr_reader :leprosorium, :stemmer, :stems, :text, :stemmed_text

  # @param text [String]
  # @return [Hash]
  def get_stems(text)
    @stems.merge!(@stemmer.call(stemmable_aliases.append(text)))
  end

  # @param text [String]
  # @return [String]
  def markup_text(text)
    entities.reduce(text) { |result, entity| markup_entity(result, entity) }
  end

  # @param text [String]
  # @param entity [Hash]
  # @return [String]
  def markup_entity(text, entity)
    mentions = find_mentions(text, entity)
    return text if mentions.blank? || mentions.any? { |m| text.match?(marked_mention_regexp(m, disclaimer(entity))) }

    m = text.match(mention_regexp(mentions.first))
    text.sub(m[0], mention_with_disclaimer(m[0], entity))
  end

  # @param mention [String]
  # @param disclaimer [String]
  # @return [Regexp]
  def marked_mention_regexp(mention, disclaimer)
    /#{mention_regexp(mention)} \(#{disclaimer}\)/
  end

  # @param mention [String]
  # @return [Regexp]
  def mention_regexp(mention)
    /([#{QUOTES}])?(#{mention})([#{QUOTES}])?/
  end

  # @param text [String]
  # @param entity [Hash]
  # @return [Array<String>]
  def find_mentions(text, entity)
    aliases = entity_aliases(entity).sort_by(&:length).reverse
    aliases.map { |a| find_mention(text, entity, a) }.compact
  end

  # @param text [String]
  # @param entity [Hash]
  # @return [String, NilClass]
  def find_mention(text, entity, entity_alias)
    entity_stemmable?(entity) ? find_stemmable_mention(text, entity_alias) : find_unstemmable_mention(text, entity_alias)
  end

  # @param text [String]
  # @param entity_alias [String]
  # @return [String, NilClass]
  def find_stemmable_mention(text, entity_alias)
    alias_size = entity_alias.split.size
    stemmed_alias = entity_alias.split.map { |w| @stems[w] }
    stemmed_text.each_cons(alias_size).with_index do |stemmed_text_part, i|
      return text.split[i..(i + alias_size - 1)].join(' ') if stemmed_text_part == stemmed_alias
    end
    nil
  end

  # @param text [String]
  # @param entity_alias [String]
  # @return [String, NilClass]
  def find_unstemmable_mention(text, entity_alias)
    text.scan(entity_alias).first
  end

  # @param text [String]
  # @return [Array<String>]
  def stem_text(text)
    @stemmed_text = text.split.map do |w|
      word = w.delete(QUOTES)
      stems[word] || word
    end
  end

  # @param mention [String]
  # @param entity [Hash]
  # @return [String]
  def mention_with_disclaimer(mention, entity)
    "#{mention} (#{disclaimer(entity)})"
  end
end

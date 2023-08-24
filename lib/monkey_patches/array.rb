# frozen_string_literal: true

class Array
  # @param element [Object]
  # @return [Array<Integer>]
  def indexes(element)
    result = []
    offset = 0

    while (i = self[offset..(size - 1)].index(element)) && offset < size
      index = i + offset
      result << index
      offset = index + 1
    end

    result
  end

  # @param list [Array]
  # @return [Array<Integer>]
  def list_indexes(list)
    indexes(list.first).select { |i| self[i..(i + list.size - 1)] == list }
  end
end

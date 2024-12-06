# frozen_string_literal: true

require 'aoc_support'

class Day4Part2 < Day4Part1
  WORD_TO_FIND = 'MAS'
  REVERSE_WORD_TO_FIND = 'SAM'

  protected

  def count_xmas(row_index, col_index)
    return 0 unless word_search[row_index][col_index] == 'A'

    xmas?(row_index, col_index) ? 1 : 0
  end

  def in_bounds?(row, col)
    return false if row + 1 >= word_search.size || (row - 1).negative?
    return false if col + 1 >= word_search[row].size || (col - 1).negative?

    true
  end

  def offset_sets_at(row_index, col_index)
    forward_diagonal = -1.upto(1).map do |i|
      [row_index + i, col_index + i]
    end

    backward_diagonal = -1.upto(1).map do |i|
      [row_index - i, col_index + i]
    end
    [forward_diagonal, backward_diagonal].freeze
  end

  def xmas?(row_index, col_index)
    return false unless in_bounds?(row_index, col_index)

    words = offset_sets_at(row_index, col_index).map do |offset_set|
      offset_set.map { |row, col| word_search[row][col] }.join
    end

    words.all? do |word|
      [WORD_TO_FIND, REVERSE_WORD_TO_FIND].include?(word)
    end
  end
end

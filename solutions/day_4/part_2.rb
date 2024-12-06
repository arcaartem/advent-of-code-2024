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

  def xmas?(row_index, col_index)
    return false if row_index + 1 >= word_search.size || (row_index - 1).negative?
    return false if col_index + 1 >= word_search[row_index].size || (col_index - 1).negative?

    word1 = []
    word2 = []

    -1.upto(1) do |i|
      word1 << word_search[row_index + i][col_index + i]
      word2 << word_search[row_index - i][col_index + i]
    end

    [word1.join, word2.join].all? do |word|
      [WORD_TO_FIND, REVERSE_WORD_TO_FIND].include?(word)
    end
  end
end

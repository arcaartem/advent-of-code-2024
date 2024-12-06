# frozen_string_literal: true

require 'aoc_support'

class Day4Part1 < AoCSolution
  WORD_TO_FIND = 'XMAS'

  attr_reader :word_search

  def solution
    read_word_search
    count_words
  end

  protected

  def read_word_search
    @word_search = input_lines.map(&:chars)
  end

  def count_words
    word_count = 0
    word_search.each_with_index do |row, row_index|
      row.each_with_index do |_letter, col_index|
        word_count += count_xmas(row_index, col_index)
      end
    end
    word_count
  end

  def count_xmas(row_index, col_index)
    return 0 unless word_search[row_index][col_index] == 'X'

    count_words_at(row_index, col_index)
  end

  # rubocop:disable Metrics/MethodLength
  def offset_sets_at(row_index, col_index)
    0.upto(3).map do |i|
      [
        [row_index, col_index + i],
        [row_index, col_index - i],
        [row_index + i, col_index],
        [row_index - i, col_index],
        [row_index - i, col_index + i],
        [row_index + i, col_index + i],
        [row_index - i, col_index - i],
        [row_index + i, col_index - i]
      ].freeze
    end
  end
  # rubocop:enable Metrics/MethodLength

  def count_words_at(row_index, col_index)
    words = Array.new(8) { [] }

    offset_sets_at(row_index, col_index).each do |offset_set|
      offset_set.each_with_index do |(row, col), index|
        words[index] << word_search[row][col] if in_bounds?(row, col)
      end
    end

    words.map!(&:join).count(WORD_TO_FIND)
  end

  def in_bounds?(row, col)
    row.between?(0, word_search.size - 1) && col.between?(0, word_search[row].size - 1)
  end
end

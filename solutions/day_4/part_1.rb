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
    @word_search = input_lines.map { |line| line.chomp.chars }
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

  def count_words_at(row_index, col_index)
    letters_to_collect = [
      ->(i) { [row_index, col_index + i] },
      ->(i) { [row_index, col_index - i] },
      ->(i) { [row_index + i, col_index] },
      ->(i) { [row_index - i, col_index] },
      ->(i) { [row_index - i, col_index + i] },
      ->(i) { [row_index + i, col_index + i] },
      ->(i) { [row_index - i, col_index - i] },
      ->(i) { [row_index + i, col_index - i] }
    ].freeze

    words = Array.new(letters_to_collect.size) { [] }

    0.upto(3) do |i|
      letters_to_collect.each_with_index do |letter_to_collect, index|
        row, col = letter_to_collect.call(i)
        next unless in_bounds?(row, col)

        words[index] << word_search[row][col]
      end
    end

    words.map(&:join).count(WORD_TO_FIND)
  end

  def in_bounds?(row, col)
    row >= 0 && row < word_search.size && col >= 0 && col < word_search[row].size
  end
end

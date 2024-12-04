# frozen_string_literal: true

require 'aoc_support'

class Day3Part1 < AoCSolution
  def solution
    input_text.scan(/mul\(\d+,\d+\)/).map do |match|
      match.scan(/\d+/).map(&:to_i).reduce(:*)
    end.reduce(:+)
  end
end

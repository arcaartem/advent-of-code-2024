# frozen_string_literal: true

require 'aoc_support'

class Day1Part2 < AoCSolution
  attr_reader :left, :right

  def solution
    read_lists
    count_matches
  end

  def read_lists
    @left = []
    @right = Hash.new(0)

    input_lines.each do |line|
      l, r = line.split.map(&:to_i)
      @left << l
      @right[r] += 1
    end
  end

  def count_matches
    count = 0
    left.each do |l|
      count += l * right[l] if right.include?(l)
    end
    count
  end
end

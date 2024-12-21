# frozen_string_literal: true

require 'aoc_support'

class Day1Part1 < AoCSolution
  attr_reader :left, :right

  def solution
    read_lists
    order_lists
    calculate_distance_sum
  end

  private

  def read_lists
    result = input_lines.map(&:split)
                        .reduce([[],
                                 []]) { |(left_list, right_list), (l, r)| [left_list << l.to_i, right_list << r.to_i] }
    @left, @right = result
  end

  def order_lists
    @left.sort!
    @right.sort!
  end

  def calculate_distance_sum
    @left.zip(@right)
         .reduce(0) { |sum, (l, r)| sum + (l - r).abs }
  end
end

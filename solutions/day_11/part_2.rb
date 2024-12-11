# frozen_string_literal: true

require 'aoc_support'

class Day11Part2 < Day11Part1
  def solution
    read_initial_arrangement
    75.times { blink }
    @arrangement.count
  end
end

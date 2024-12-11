# frozen_string_literal: true

require 'aoc_support'

class Day11Part2 < Day11Part1
  def solution
    solve_for(75)
  end

  protected

  def solve_for(iterations)
    read_initial_arrangement
    @stone_count_per_iteration = {}
    @arrangement.length + @arrangement.map { |stone| blink_for(stone, iterations) }.sum
  end

  def blink_for(stone, iterations)
    return @stone_count_per_iteration[[stone, iterations]] if @stone_count_per_iteration[[stone, iterations]]

    current_stone = stone
    arrangement_count = 0

    iterations.times do |iteration|
      new_arrangement = apply_rules(current_stone)
      current_stone = new_arrangement.first
      arrangement_count += blink_for(new_arrangement.last, iterations - iteration - 1) + 1 if new_arrangement.length > 1
    end

    @stone_count_per_iteration[[stone, iterations]] = arrangement_count
    arrangement_count
  end
end

# frozen_string_literal: true

require 'aoc_support'

class Day11Part1 < AoCSolution
  def solution
    solve_for(25)
  end

  protected

  def solve_for(iterations)
    read_initial_arrangement
    visualise_arrangement
    iterations.times { blink }
    visualise_arrangement
    @arrangement.count
  end

  def debug?
    false
  end

  def visualise_arrangement
    return unless debug?

    puts 'Arrangement visualization: '
    puts '-----------------------------------'
    puts @arrangement.to_a.join(' ')
    puts '==================================='
  end

  def read_initial_arrangement
    @arrangement = input_text.split.map(&:to_i)
  end

  def blink
    new_arrangement = []
    @arrangement.each do |stone|
      new_arrangement.concat(apply_rules(stone))
    end
    @arrangement = new_arrangement
  end

  def apply_rules(stone)
    return [1] if stone.zero?

    length = Math.log10(stone).to_i + 1

    if length.even?
      right_half = stone % (10**(length / 2))
      left_half = stone / (10**(length / 2))
      return [left_half, right_half]
    end

    [stone * 2024]
  end
end

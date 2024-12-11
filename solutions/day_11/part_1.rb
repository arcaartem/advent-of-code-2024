# frozen_string_literal: true

require 'aoc_support'

class Day11Part1 < AoCSolution
  def solution
    read_initial_arrangement
    25.times { blink }
    @arrangement.count
  end

  protected

  def read_initial_arrangement
    @arrangement = input_text.chomp.split.map(&:to_i)
  end

  def blink
    new_arrangement = []
    @arrangement.each do |stone|
      new_arrangement += apply_rules(stone)
    end

    @arrangement = new_arrangement
  end

  def apply_rules(stone)
    return [1] if stone.zero?

    digit_count = StoneSplitter.count_digits(stone)

    return StoneSplitter.split_stone(stone, digit_count / 2) if digit_count.even?

    [stone * 2024]
  end
end

class StoneSplitter
  def self.split_stone(stone, count)
    current_stone = stone
    multiplier = 1

    count.times do
      multiplier *= 10
      current_stone /= 10
    end

    left_stone = current_stone
    right_stone = stone % multiplier

    [left_stone, right_stone]
  end

  def self.count_digits(stone)
    current_stone = stone
    count = 0

    while current_stone >= 10
      current_stone /= 10
      count += 1
    end

    count += 1 if current_stone.positive?
    count
  end
end

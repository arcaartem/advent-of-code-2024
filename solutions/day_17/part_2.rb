# frozen_string_literal: true

require 'aoc_support'

class Day17Part2 < Day17Part1
  def solution
    read_instructions
    initialize_computer
    find_minimum_reg_a
  end

  protected

  def find_count_for(count, expected_output)
    count += 1 until computer.reset(instructions, reg_a: count).execute == expected_output
    count
  end

  def find_minimum_reg_a
    (instructions.length - 1).downto(0).reduce(0) do |count, i|
      expected_output = instructions[i..]
      find_count_for(count * 8, expected_output)
    end
  end
end

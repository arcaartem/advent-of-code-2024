# frozen_string_literal: true

require 'aoc_support'

class Day17Part2 < Day17Part1
  def solution
    read_instructions
    initialize_computer
    find_minimum_reg_a
  end

  protected

  def find_minimum_reg_a
    guess = 0
    (instructions.length - 1).downto(0) do |i|
      expected_output = instructions[i..]
      guess *= 8

      loop do
        computer.reset(instructions, reg_a: guess)
        output = computer.execute
        break if output == expected_output

        guess += 1
      end
    end
    guess
  end
end

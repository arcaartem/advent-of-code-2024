# frozen_string_literal: true

require 'aoc_support'
require_relative 'chronospatial_computer'

class Day17Part1 < AoCSolution
  attr_reader :instructions, :computer, :reg_a, :reg_b, :reg_c

  def solution
    read_instructions
    initialize_computer
    run_program
  end

  protected

  def debug?
    false
  end

  def read_instructions
    lines = input_lines.to_a
    @reg_a = parse_register(lines.shift)
    @reg_b = parse_register(lines.shift)
    @reg_c = parse_register(lines.shift)
    lines.shift
    @instructions = parse_instructions(lines.shift)
  end

  def initialize_computer
    @computer = ChronospatialComputer.new(instructions, reg_a: reg_a, reg_b: reg_b, reg_c: reg_c, debug: debug?)
  end

  def run_program
    if debug?
      result = true
      while result
        # binding.pry
        result = computer.step
      end
      computer.output_buffer.join(',')
    else
      computer.execute.join(',')
    end
  end

  def parse_register(line)
    line.split(':').last.to_i
  end

  def parse_instructions(line)
    line.split(':').last.split(',').map(&:to_i)
  end
end

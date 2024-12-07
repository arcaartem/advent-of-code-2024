# frozen_string_literal: true

require 'aoc_support'

class Day7Part2 < Day7Part1
  attr_reader :equations

  def solution
    read_equations
    sum_valid_equations
  end

  protected

  def available_operators
    [
      ->(a, b) { a + b },
      ->(a, b) { a * b },
      ->(a, b) { (a.to_s + b.to_s).to_i }
    ]
  end
end

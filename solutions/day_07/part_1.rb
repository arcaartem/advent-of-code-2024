# frozen_string_literal: true

require 'aoc_support'

class Day7Part1 < AoCSolution
  attr_reader :equations

  def solution
    read_equations
    sum_valid_equations
  end

  protected

  def available_operators
    [
      ->(a, b) { a + b },
      ->(a, b) { a * b }
    ]
  end

  def read_equations
    @equations = input_lines.map do |line|
      test_value, numbers = line.split(':').map(&:chomp)
      [test_value.to_i, numbers.split.map(&:to_i)]
    end
  end

  def sum_valid_equations
    equations.filter do |equation|
      valid_equation?(*equation)
    end.sum(&:first)
  end

  def valid_equation?(test_value, numbers)
    available_operators.repeated_permutation(numbers.size - 1).any? do |operators|
      evaluate_equation(numbers, operators) == test_value
    end
  end

  def evaluate_equation(numbers, operators)
    numbers.zip([nil] + operators).reduce(0) do |acc, (num, op)|
      op.nil? ? num : op.call(acc, num)
    end
  end
end

# frozen_string_literal: true

require 'aoc_support'

class Day3Part2 < AoCSolution
  def solution
    matches = input_text.scan(/mul\(\d+,\d+\)|do\(\)|don't\(\)/)
    result = matches.reduce([true, 0]) do |state, match|
      update_sum(state, match)
    end
    result.last
  end

  private

  def update_sum((mul_active, sum), match)
    if match.start_with?('mul')
      sum += match.scan(/\d+/).map(&:to_i).reduce(:*) if mul_active
    elsif match == 'do()'
      mul_active = true
    elsif match == "don't()"
      mul_active = false
    end
    [mul_active, sum]
  end
end

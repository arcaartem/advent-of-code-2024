# frozen_string_literal: true

require 'aoc_support'

class Day8Part2 < Day8Part1
  protected

  def calculate_antinodes_for_antenna_pair(position1, position2)
    distance = calculate_distance(position1, position2)
    slope = calculate_slope(position1, position2)

    antinodes_for_antenna_pair = []
    sign = slope.negative? ? -1.0 : 1.0
    multiplier = 0.0

    loop do
      new_point1 = find_new_point(position1, slope, sign * multiplier * distance)
      new_point2 = find_new_point(position1, slope, sign * -1 * multiplier * distance)

      break if !in_bounds?(*new_point1) && !in_bounds?(*new_point2)

      antinodes_for_antenna_pair << new_point1
      antinodes_for_antenna_pair << new_point2

      multiplier += 1.0
    end
    antinodes_for_antenna_pair.uniq
  end
end

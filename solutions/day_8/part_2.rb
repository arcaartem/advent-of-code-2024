# frozen_string_literal: true

require 'aoc_support'

class Day8Part2 < Day8Part1
  protected

  def calculate_antinodes_for_antenna_pair(position1, position2)
    distance = calculate_distance(position1, position2)
    slope = calculate_slope(position1, position2)

    antinodes_for_antenna_pair = []
    sign = slope.negative? ? -1.0 : 1.0

    antinodes_for_antenna_pair += calculate_new_antinodes(position1, slope, sign, 1, distance)
    antinodes_for_antenna_pair += calculate_new_antinodes(position1, slope, sign, -1, distance)
    antinodes_for_antenna_pair.uniq
  end

  def calculate_new_antinodes(position1, slope, sign, direction, distance)
    antinodes_for_antenna_pair = []
    multiplier = 0.0
    loop do
      new_point = find_new_point(position1, slope, sign * direction * multiplier * distance)

      break unless in_bounds?(*new_point)

      antinodes_for_antenna_pair << new_point

      multiplier += 1.0
    end
    antinodes_for_antenna_pair
  end
end

# frozen_string_literal: true

require 'aoc_support'

class Day8Part1 < AoCSolution
  attr_reader :antenna_map, :antennas, :antinodes

  def solution
    read_antenna_map
    find_antennas
    calculate_all_antinodes
    visualise_map
    count_antinodes
  end

  protected

  def read_antenna_map
    @antenna_map = input_lines.map do |line|
      line.chomp.chars
    end
  end

  def find_antennas
    @antennas = {}

    antenna_map.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        next if cell == '.'

        antennas[cell] = [] if antennas[cell].nil?
        antennas[cell] << [col_index, row_index]
      end
    end
  end

  def visualise_map
    puts 'Map:'
    puts '-' * antenna_map.first.length
    puts (antenna_map.map.with_index do |row, row_index|
      (row.map.with_index do |cell, col_index|
        if cell == '.' && antinode_exists?(row_index, col_index)
          '#'
        else
          cell
        end
      end).join
    end).join("\n")
    puts '-' * antenna_map.first.length
  end

  def antinode_exists?(row, col)
    antinodes.values.any? do |positions|
      positions.include?([col, row])
    end
  end

  def calculate_all_antinodes
    @antinodes = {}
    antennas.each do |antenna, positions|
      @antinodes[antenna] = calculate_antinodes(positions)
    end
  end

  def calculate_antinodes(positions)
    antinodes_positions = []
    0.upto(positions.length - 2).each do |i|
      (i + 1).upto(positions.length - 1).each do |j|
        next if i == j

        new_antinode_positions = calculate_antinodes_for_antenna_pair(positions[i], positions[j])
        antinodes_positions += new_antinode_positions
      end
    end
    antinodes_positions.uniq
  end

  def in_bounds?(row, col)
    row >= 0 && row < antenna_map.length && col >= 0 && col < antenna_map.first.length
  end

  def calculate_antinodes_for_antenna_pair(position1, position2)
    distance = calculate_distance(position1, position2)
    slope = calculate_slope(position1, position2)

    antinodes_for_antenna_pair = []
    sign = slope.negative? ? -1 : 1

    antinodes_for_antenna_pair << find_new_point(position1, slope, sign * -1 * distance)
    antinodes_for_antenna_pair << find_new_point(position1, slope, sign * 2 * distance)

    antinodes_for_antenna_pair
  end

  def calculate_distance(position1, position2)
    col1, row1 = position1
    col2, row2 = position2

    Math.sqrt(((row1 - row2)**2) + ((col1 - col2)**2))
  end

  def calculate_slope(position1, position2)
    col1, row1 = position1
    col2, row2 = position2
    (row2 - row1).to_f / (col2 - col1)
  end

  def count_antinodes
    antinodes.values.flatten(1).filter { |p| in_bounds?(*p) }.uniq.length
  end

  def find_new_point(position, slope, distance)
    col, row = position
    theta = Math.atan(slope)
    new_row = row + (distance * Math.sin(theta))
    new_col = col + (distance * Math.cos(theta))
    [new_col.round, new_row.round]
  end
end

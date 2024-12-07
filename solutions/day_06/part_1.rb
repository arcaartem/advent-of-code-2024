# frozen_string_literal: true

require 'aoc_support'

class Day6Part1 < AoCSolution
  DIRECTIONS = %w[^ > v <].freeze
  DIRECTION_OFFSETS = {
    '^' => [-1, 0],
    '>' => [0, 1],
    'v' => [1, 0],
    '<' => [0, -1]
  }.freeze
  RIGHT_DIRECTION = {
    '^' => '>',
    '>' => 'v',
    'v' => '<',
    '<' => '^'
  }.freeze

  attr_reader :map, :traversed

  def solution
    read_map
    current_position, current_direction = find_starting_position
    predict_route(current_position, current_direction)
    count_traversed
  end

  protected

  def read_map
    @map = input_lines.map(&:chars)
  end

  def find_starting_position
    map.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        next unless DIRECTIONS.include?(cell)

        return [row_index, col_index], cell
      end
    end
  end

  def predict_route(position, direction)
    @traversed = Array.new(row_count) { Array.new(col_count, false) }

    while in_bounds?(position)
      traversed[position[0]][position[1]] = true

      if obstacle?(position, direction)
        direction = RIGHT_DIRECTION[direction]
      else
        position = new_position(position, direction)
      end
    end
  end

  def new_position(position, direction)
    offset = DIRECTION_OFFSETS[direction]

    [position[0] + offset[0], position[1] + offset[1]]
  end

  def in_bounds?(current_position)
    row, col = current_position
    row >= 0 && row < row_count && col >= 0 && col < col_count
  end

  def count_traversed
    traversed.flatten.count(true)
  end

  def print_traversed
    traversed.each do |row|
      puts row.map { |cell| cell ? 'X' : '.' }.join
    end
  end

  def row_count
    @row_count ||= map.size
  end

  def col_count
    @col_count ||= map.first.size
  end

  def obstacle?(position, direction)
    new_position = new_position(position, direction)
    return false unless in_bounds?(new_position)

    map[new_position[0]][new_position[1]] == '#'
  end
end

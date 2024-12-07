# frozen_string_literal: true

require 'aoc_support'

class Day6Part1 < AoCSolution
  DIRECTIONS = %w[^ > v <].freeze

  attr_reader :map, :traversed, :current_position, :direction

  def solution
    read_map
    find_starting_position
    predict_route
    count_traversed
  end

  protected

  def read_map
    @map = input_lines.map do |line|
      line.chomp.chars
    end
  end

  def find_starting_position
    map.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        next unless DIRECTIONS.include?(cell)

        @current_position = [row_index, col_index]
        @direction = cell
        break
      end
    end
  end

  def predict_route
    @traversed = Array.new(map.size) { Array.new(map.first.size, false) }

    loop do
      break unless in_bounds?(*current_position)

      traversed[current_position.first][current_position.last] = true

      if obstacle?(*current_position)
        turn_right
      else
        move_forward
      end
    end
  end

  def move_forward
    directions = {
      '^' => [-1, 0],
      '>' => [0, 1],
      'v' => [1, 0],
      '<' => [0, -1]
    }

    step = directions[direction]
    row, col = current_position
    @current_position = [row + step.first, col + step.last]
  end

  def turn_right
    new_direction = {
      '^' => '>',
      '>' => 'v',
      'v' => '<',
      '<' => '^'
    }

    @direction = new_direction[direction]
  end

  def in_bounds?(row, col)
    row >= 0 && row < map.size && col >= 0 && col < map[row].size
  end

  def count_traversed
    traversed.flatten.count(true)
  end

  def print_traversed
    traversed.each do |row|
      puts row.map { |cell| cell ? 'X' : '.' }.join
    end
  end

  def obstacle?(row, col)
    case direction
    when '^'
      row - 1 >= 0 && map[row - 1][col] == '#'
    when '>'
      col + 1 < map[row].size && map[row][col + 1] == '#'
    when 'v'
      row + 1 < map.size && map[row + 1][col] == '#'
    when '<'
      col - 1 >= 0 && map[row][col - 1] == '#'
    end
  end
end

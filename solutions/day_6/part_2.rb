# frozen_string_literal: true

require 'aoc_support'

class Day6Part2 < Day6Part1
  def solution
    read_map
    starting_position, starting_direction = find_starting_position
    count_new_obstructions(starting_position, starting_direction)
  end

  protected

  def count_new_obstructions(starting_position, starting_direction)
    count = 0

    map.each_with_index do |row, row_index|
      row.each_with_index do |old_cell, col_index|
        next if DIRECTIONS.include?(old_cell)
        next if old_cell == '#'

        map[row_index][col_index] = '#'
        current_position = predict_route(starting_position, starting_direction)
        count += 1 if in_bounds?(current_position)
        map[row_index][col_index] = old_cell
      end
    end
    count
  end

  def predict_route(starting_position, starting_direction)
    @traversed = Array.new(map.size) { Array.new(map.first.size, false) }
    current_position = starting_position
    current_direction = starting_direction

    loop do
      break if !in_bounds?(current_position) || loop?(traversed, current_position, current_direction)

      unless traversed[current_position.first][current_position.last]
        traversed[current_position.first][current_position.last] = current_direction
      end

      if obstacle?(current_position, current_direction)
        current_direction = turn_right(current_direction)
      else
        current_position = move_forward(current_position, current_direction)
      end
    end

    current_position
  end

  def loop?(traversed, current_position, current_direction)
    traversed[current_position.first][current_position.last] == current_direction
  end
end

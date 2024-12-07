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
        next if DIRECTIONS.include?(old_cell) || old_cell == '#'

        map[row_index][col_index] = '#'
        count += 1 if in_bounds?(predict_route(starting_position, starting_direction))
        map[row_index][col_index] = old_cell
      end
    end
    count
  end

  def predict_route(position, direction)
    @traversed = Array.new(row_count) { Array.new(col_count, false) }

    while in_bounds?(position) && !loop?(traversed, position, direction)

      mark_traversed(position, direction)

      if obstacle?(position, direction)
        direction = RIGHT_DIRECTION[direction]
      else
        position = new_position(position, direction)
      end
    end

    position
  end

  def loop?(traversed, current_position, current_direction)
    traversed[current_position[0]][current_position[1]] == current_direction
  end

  def mark_traversed(position, direction)
    @traversed[position[0]][position[1]] ||= direction
  end
end

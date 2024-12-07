# frozen_string_literal: true

require 'aoc_support'

class Day6Part2 < Day6Part1
  def solution
    read_map
    find_starting_position
    count_new_obstructions
  end

  protected

  def count_new_obstructions
    starting_position = current_position.dup
    starting_direction = direction.dup
    count = 0

    map.each_with_index do |row, row_index|
      row.each_with_index do |_, col_index|
        @current_position = starting_position.dup
        @direction = starting_direction.dup
        old_cell = map[row_index][col_index]

        map[row_index][col_index] = '#'
        predict_route
        count += 1 if in_bounds?(*current_position)
        map[row_index][col_index] = old_cell
      end
    end
    count
  end

  def predict_route
    @traversed = Array.new(map.size) { Array.new(map.first.size, false) }

    loop do
      break if !in_bounds?(*current_position) || loop?(traversed)

      unless traversed[current_position.first][current_position.last]
        traversed[current_position.first][current_position.last] = direction
      end

      if obstacle?(*current_position)
        turn_right
      else
        move_forward
      end
    end
  end

  def loop?(traversed)
    traversed[current_position.first][current_position.last] == direction
  end
end

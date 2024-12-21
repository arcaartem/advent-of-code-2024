# frozen_string_literal: true

class Day16Visualizer
  DIRECTIONS = [
    [-1, 0, :up],
    [1, 0, :down],
    [0, -1, :left],
    [0, 1, :right]
  ].freeze

  DIRECTION_MARKS = {
    up: '^',
    down: 'v',
    left: '<',
    right: '>'
  }.freeze

  def self.visualize_path(maze, start_node, end_node, path)
    new(maze, start_node, end_node).visualize_path(path)
  end

  def initialize(maze, start_node, end_node)
    @maze = maze
    @start_node = start_node
    @end_node = end_node
  end

  def visualize_path((path, _cost))
    path.each_cons(2) do |prev_pos, current_pos|
      direction = find_direction(prev_pos, current_pos)

      mark_cursor_position(current_pos, direction)
    end

    puts @maze.map(&:join)
  end

  private

  def mark_cursor_position(pos, direction)
    return if [@start_node, @end_node].include?(pos)

    @maze[pos[0]][pos[1]] = DIRECTION_MARKS[direction]
  end

  def find_direction(from, to)
    DIRECTIONS.each do |delta_row, delta_col, direction|
      new_pos = [from[0] + delta_row, from[1] + delta_col]
      return direction if new_pos == to
    end
  end
end

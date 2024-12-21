# frozen_string_literal: true

class DFS
  DIRECTIONS = [[0, 1, 'v'], [1, 0, '>'], [0, -1, '^'], [-1, 0, '<']].freeze

  attr_reader :all_paths, :grid, :length, :width, :pad

  def self.find_all_paths(pad, start_pos, end_pos)
    DFS.new(pad).find_all_paths(start_pos, end_pos)
  end

  def initialize(pad)
    @pad = pad
    @length = pad.length
    @width = pad[0].length
    @all_paths = []
    @grid = Array.new(@length) { Array.new(@width, false) }
  end

  def find_all_paths(start_pos, end_pos)
    @all_paths = []

    dfs(start_pos, end_pos, [], nil)
    @all_paths
  end

  private

  def dfs(current_pos, target_pos, current_path, direction)
    if current_pos == target_pos
      all_paths << (current_path.dup + [direction, 'A'].compact)
      return
    end

    x, y = current_pos

    grid[y][x] = true

    current_path << direction if direction
    traverse_all_directions(target_pos, current_path)

    grid[y][x] = false
    current_path.pop
  end

  def traverse_all_directions(target_pos, current_path)
    DIRECTIONS.each do |dx, dy, new_direction|
      x, y = target_pos
      new_pos = [x + dx, y + dy]
      dfs(new_pos, target_pos, current_path, new_direction) if traversable?(new_pos)
    end
  end

  def within_bounds?(pos_x, pos_y)
    pos_y.between?(0, length - 1) && pos_x.between?(0, width - 1)
  end

  def gap?(pos_x, pos_y) = pad[pos_y][pos_x] == ' '

  def traversed?(pos_x, pos_y) = grid[pos_y][pos_x]

  def traversable?(pos)
    pos_x, pos_y = pos
    within_bounds?(pos_x, pos_y) && !gap?(pos_x, pos_y) && !traversed?(pos_x, pos_y)
  end
end

# frozen_string_literal: true

require 'aoc_support'

class Day16Part1 < AoCSolution
  MAX_COST = 999_999_999_999
  DIRECTIONS = [
    [-1, 0, :up],
    [1, 0, :down],
    [0, -1, :left],
    [0, 1, :right]
  ].freeze

  attr_reader :maze, :rows, :cols, :start_node, :end_node, :scores, :paths

  def solution
    read_maze
    find_start_and_end_nodes
    score, path = find_lowest_score_path(maze)
    visualize_path(path)
    score
  end

  def read_maze
    @maze = input_lines.map do |line|
      line.chomp.chars
    end

    @rows = maze.size
    @cols = maze[0].size
  end

  def find_start_and_end_nodes
    @start_node = nil
    @end_node = nil
    rows.times do |r|
      cols.times do |c|
        @start_node = [r, c] if maze[r][c] == 'S'
        @end_node = [r, c] if maze[r][c] == 'E'
      end
    end
  end

  def visualize_path(path)
    cursor = start_node
    path.each do |direction|
      case direction
      when :up
        maze[cursor[0]][cursor[1]] = '^' unless cursor == start_node || cursor == end_node
        cursor = [cursor[0] - 1, cursor[1]]
      when :down
        maze[cursor[0]][cursor[1]] = 'v' unless cursor == start_node || cursor == end_node
        cursor = [cursor[0] + 1, cursor[1]]
      when :left
        maze[cursor[0]][cursor[1]] = '<' unless cursor == start_node || cursor == end_node
        cursor = [cursor[0], cursor[1] - 1]
      when :right
        maze[cursor[0]][cursor[1]] = '>' unless cursor == start_node || cursor == end_node
        cursor = [cursor[0], cursor[1] + 1]
      end
    end

    puts maze.map(&:join)
  end

  def find_lowest_score_path(maze)
    @scores = Array.new(rows) { Array.new(cols, nil) }
    @paths = Array.new(rows) { Array.new(cols, nil) }

    @scores[start_node[0]][start_node[1]] = 0

    queue = []
    queue.push([start_node, nil, []])

    binding.pry
    until queue.empty?
      current_pos, current_direction, current_route = queue.pop

      DIRECTIONS.each do |delta_row, delta_col, direction|
        binding.pry
        row = current_pos[0] + delta_row
        col = current_pos[1] + delta_col
        new_pos = [row, col]

        next unless in_bounds?(new_pos)
        next if maze[row][col] == '#'

        new_cost = (cost_of(current_pos) || 0) + (current_direction.nil? || current_direction == direction ? 1 : 1000)
        new_route = current_route << direction

        next if cost_of(new_pos) && new_cost >= cost_of(new_pos)

        set_cost(new_pos, new_cost)
        set_route(new_pos, new_route)
        queue.push([new_pos, direction, new_route])
      end
    end
    [cost_of(end_node), route_of(end_node)]
  end

  def in_bounds?(pos)
    !(pos[0].negative? || pos[0] >= rows || pos[1].negative? || pos[1] >= cols)
  end

  def cost_of(pos)
    scores[pos[0]][pos[1]]
  end

  def set_cost(pos, cost)
    scores[pos[0]][pos[1]] = cost
  end

  def route_of(pos)
    paths[pos[0]][pos[1]]
  end

  def set_route(pos, route)
    paths[pos[0]][pos[1]] = route
  end
end

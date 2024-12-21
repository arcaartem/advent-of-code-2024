# frozen_string_literal: true

class Day16Bfs
  attr_reader :paths

  ALLOWED_DIRECTIONS = {
    north: [[-1, 0, :north], [0, -1, :west], [0, 1, :east]],
    south: [[1, 0, :south], [0, -1, :west], [0, 1, :east]],
    west: [[-1, 0, :north], [1, 0, :south], [0, -1, :west]],
    east: [[-1, 0, :north], [1, 0, :south], [0, 1, :east]]
  }.freeze

  def self.bfs(maze, start_pos, end_pos)
    instance = new(maze, start_pos, end_pos)
    instance.bfs
  end

  def initialize(maze, start_pos, end_pos)
    @start_pos = start_pos
    @end_pos = end_pos
    @maze = maze
    @rows = maze.size
    @cols = maze[0].size
    @paths = []
  end

  def bfs
    find_paths_bfs(@maze)
  end

  private

  def find_paths_bfs(maze)
    queue = [[@start_pos, [@start_pos], :east, 0]]
    paths = []
    costs = Array.new(@rows) { Array.new(@cols, Float::INFINITY) }

    until queue.empty?
      current, path, prev_dir, current_cost = queue.shift
      y, x = current

      next if x.negative? || y.negative? || x >= @cols || y >= @rows || maze[y][x] == '#' || current_cost > costs[y][x]

      if maze[y][x] == 'E'
        paths << [path, current_cost]
        next
      end

      costs[y][x] = current_cost

      ALLOWED_DIRECTIONS[prev_dir].each do |dy, dx, dd|
        new_pos = [y + dy, x + dx]
        new_cost = current_cost + (prev_dir == dd ? 1 : 1001)
        queue.push([new_pos, path + [new_pos], dd, new_cost])
      end
    end

    paths
  end
end

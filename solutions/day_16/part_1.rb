# frozen_string_literal: true

require 'aoc_support'
require_relative 'day_16_bfs'
require_relative 'day_16_visualizer'

class Day16Part1 < AoCSolution
  def solution
    read_maze
    find_start_and_end_nodes
    find_all_paths
    path = find_lowest_score_path
    Day16Visualizer.visualize_path(@maze, @start_node, @end_node, path) if debug?
    cost_of_path(path)
  end

  protected

  def read_maze
    @maze = input_lines.map(&:chars)
    @rows = @maze.size
    @cols = @maze[0].size
  end

  def find_start_and_end_nodes
    @start_node = nil
    @end_node = nil
    @rows.times do |r|
      @cols.times do |c|
        @start_node = [r, c] if @maze[r][c] == 'S'
        @end_node = [r, c] if @maze[r][c] == 'E'
      end
    end
  end

  def find_all_paths
    @paths = Day16Bfs.bfs(@maze, @start_node, @end_node)
  end

  def find_lowest_score_path
    @paths.min_by { |(_path, cost)| cost }
  end

  def cost_of_path((_path, cost))
    cost
  end
end

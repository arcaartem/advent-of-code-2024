# frozen_string_literal: true

require 'aoc_support'

class Day16Part2 < Day16Part1
  def solution
    read_maze
    find_start_and_end_nodes
    find_all_paths
    path = find_lowest_score_path
    cost = cost_of_path(path)

    low_cost_paths = find_all_lowest_cost_paths(cost)

    Set.new(low_cost_paths.flatten(1)).size
  end

  protected

  def find_all_lowest_cost_paths(cost)
    @paths.select { |(_path, c)| c == cost }.map(&:first)
  end
end

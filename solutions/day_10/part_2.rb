# frozen_string_literal: true

require 'aoc_support'

class Day10Part2 < Day10Part1
  attr_reader :topology_map

  def solution
    read_topology_map
    traverse_map
    @total_score
  end

  protected

  def start_traversal(row_index, col_index, cell)
    @current_score = {}
    @traversed = Array.new(@topology_map.size) { Array.new(@topology_map.first.size, false) }
    traverse_from(row_index, col_index, cell, [row_index, col_index])
    visualize_traversal(row_index, col_index) if debug?
    @total_score += @current_score[[row_index, col_index]]
  end

  def traverse_from(row_index, col_index, elevation, origin)
    return if @topology_map[row_index][col_index] != elevation

    @traversed[row_index][col_index] = true

    if elevation == 9
      @current_score[origin] ||= 0
      @current_score[origin] += 1
      return
    end

    [[1, 0], [-1, 0], [0, 1], [0, -1]].each do |(dy, dx)|
      traverse_from(row_index + dy, col_index + dx, elevation + 1, origin) if in_bounds?(row_index + dy, col_index + dx)
    end
  end
end

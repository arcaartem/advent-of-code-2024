# frozen_string_literal: true

require 'aoc_support'

class Day10Part1 < AoCSolution
  attr_reader :topology_map

  def solution
    read_topology_map
    traverse_map
    @total_score
  end

  protected

  def debug? = false

  def read_topology_map
    @topology_map = input_lines.map do |line|
      line.chars.map(&:to_i)
    end
  end

  def traverse_map
    @total_score = 0

    @topology_map.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        next unless cell.zero?

        start_traversal(row_index, col_index, cell)
      end
    end
  end

  def start_traversal(row_index, col_index, cell)
    @current_score = 0
    @traversed = Array.new(@topology_map.size) { Array.new(@topology_map.first.size, false) }
    traverse_from(row_index, col_index, cell)
    visualize_traversal(row_index, col_index) if debug?
    @total_score += @current_score
  end

  def in_bounds?(row_index, col_index)
    row_index >= 0 && row_index < @topology_map.size && col_index >= 0 && col_index < @topology_map.first.size
  end

  def traverse_from(row_index, col_index, elevation)
    return if @traversed[row_index][col_index] || @topology_map[row_index][col_index] != elevation

    @traversed[row_index][col_index] = true

    if elevation == 9
      @current_score += 1
      return
    end

    [[1, 0], [-1, 0], [0, 1], [0, -1]].each do |(dy, dx)|
      traverse_from(row_index + dy, col_index + dx, elevation + 1) if in_bounds?(row_index + dy, col_index + dx)
    end
  end

  def visualize_traversal(row_index, col_index)
    puts '=================='
    puts "Hike path (Start X: #{col_index}, Y: #{row_index}, Current score: #{@current_score})"
    puts '------------------'
    @topology_map.each_with_index do |row, r|
      row.each_with_index { |cell, c| print @traversed[r][c] ? cell : '.' }
      puts
    end
    p @traversed
    puts '=================='
  end
end

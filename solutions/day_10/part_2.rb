# frozen_string_literal: true

require 'aoc_support'

class Day10Part2 < AoCSolution
  attr_reader :topology_map

  def solution
    read_topology_map
    traverse_map
    @total_score
  end

  protected

  def read_topology_map
    @topology_map = input_lines.map do |line|
      line.chomp.chars.map(&:to_i)
    end
  end

  def traverse_map
    @total_score = 0

    @topology_map.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        next unless cell.zero?

        @current_score = {}
        @traversed = Array.new(@topology_map.size) { Array.new(@topology_map.first.size, false) }
        traverse_from(row_index, col_index, cell, [row_index, col_index])
        visualize_traversal(row_index, col_index)
        @total_score += @current_score[[row_index, col_index]]
      end
    end
  end

  def traverse_from(row_index, col_index, elevation, origin)
    return if @topology_map[row_index][col_index] != elevation

    @traversed[row_index][col_index] = true

    if elevation == 9
      @current_score[origin] ||= 0
      @current_score[origin] += 1
      return
    end

    traverse_from(row_index + 1, col_index, elevation + 1, origin) if row_index + 1 <= @topology_map.size - 1
    traverse_from(row_index - 1, col_index, elevation + 1, origin) if row_index - 1 >= 0
    traverse_from(row_index, col_index + 1, elevation + 1, origin) if col_index + 1 <= @topology_map.first.size - 1
    traverse_from(row_index, col_index - 1, elevation + 1, origin) if col_index - 1 >= 0
  end

  def visualize_traversal(row_index, col_index)
    return unless debug?

    puts '=================='
    puts "Hike path (Start X: #{col_index}, Y: #{row_index}, Current score: #{@current_score})"
    puts '------------------'
    @topology_map.each_with_index do |row, r|
      row.each_with_index do |cell, c|
        if @traversed[r][c]
          print cell
        else
          print '.'
        end
      end
      puts
    end
    p @traversed
    puts '=================='
  end

  def debug?
    false
  end
end

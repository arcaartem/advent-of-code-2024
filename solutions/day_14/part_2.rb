# frozen_string_literal: true

require 'aoc_support'

class Day14Part2 < Day14Part1
  def solution
    read_robot_positions_and_velocity
    10_000.times do |iteration|
      if robots_clustered?
        visualize_robots
        return iteration
      end
      move_robots
    end
    -1
  end

  protected

  def debug?
    false
  end

  def max_longest_consecutive_sequence_lenght
    all_positions = {}

    @robot_positions_and_velocity.each do |robot|
      all_positions[robot[:position][:y]] = Set.new if all_positions[robot[:position][:y]].nil?
      all_positions[robot[:position][:y]] << robot[:position][:x]
    end

    max_lcs = 1
    all_positions.each do |value|
      _key, positions = value
      lcs = longest_consecutive_sequence_length(positions.to_a.sort)
      max_lcs = [max_lcs, lcs].max
    end

    max_lcs
  end

  def longest_consecutive_sequence_length(positions)
    return 0 if positions.empty?

    max_lcs = 1
    current_lcs = 1
    last_position = positions.first

    positions.each do |position|
      if position == last_position + 1
        current_lcs += 1
        max_lcs = [max_lcs, current_lcs].max
      else
        current_lcs = 1
      end
      last_position = position
    end

    max_lcs
  end

  def robots_clustered?
    threshold = 10

    return true if max_longest_consecutive_sequence_lenght > threshold

    false
  end

  def visualize_robots(iteration = nil)
    log("Iteration: #{iteration}") if iteration
    grid = Array.new(height) { Array.new(width, ' ') }
    @robot_positions_and_velocity.each do |robot|
      grid[robot[:position][:y]][robot[:position][:x]] = '#'
    end

    grid.each do |row|
      log(row.join)
    end
    log '-' * width
  end

  def log(message)
    message = "#{message}\n"
    if debug?
      File.write('output.txt', message, mode: 'a')
    else
      puts message
    end
  end
end

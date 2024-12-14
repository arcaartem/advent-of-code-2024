# frozen_string_literal: true

require 'aoc_support'

class Day14Part2 < Day14Part1
  def solution
    read_robot_positions_and_velocity
    10_000.times do |iteration|
      if robots_clustered?
        visualize_robots if debug?
        return iteration
      end
      move_robots
    end
    -1
  end

  protected

  def debug? = false

  def find_all_positions
    @robot_positions_and_velocity.each_with_object({}) do |robot, all_positions|
      all_positions[robot[:position][:y]] ||= Set.new
      all_positions[robot[:position][:y]] << robot[:position][:x]
    end
  end

  def max_longest_consecutive_sequence_lenght
    all_positions = find_all_positions

    all_positions.each_value.reduce(1) do |max_lcs, positions|
      lcs = longest_consecutive_sequence_length(positions.to_a.sort)
      [max_lcs, lcs].max
    end
  end

  def longest_consecutive_sequence_length(positions)
    return 0 if positions.empty?

    positions.reduce([1, 1, positions.first]) do |acc, position|
      (max_lcs, current_lcs, last_position) = acc

      if position == last_position + 1
        [[max_lcs, current_lcs].max, current_lcs + 1, position]
      else
        [max_lcs, 1, position]
      end
    end[0]
  end

  def robots_clustered?
    threshold = 10

    return true if max_longest_consecutive_sequence_lenght > threshold

    false
  end

  def mark_robot_position(grid, robot)
    y = robot[:position][:y]
    x = robot[:position][:x]
    grid[y][x] = '#'
  end

  def visualize_robots(iteration = nil)
    log("Iteration: #{iteration}") if iteration

    grid = Array.new(height) { Array.new(width, ' ') }

    @robot_positions_and_velocity.each do |robot|
      mark_robot_position(grid, robot)
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

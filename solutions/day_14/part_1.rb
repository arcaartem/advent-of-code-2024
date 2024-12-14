# frozen_string_literal: true

require 'aoc_support'

class Day14Part1 < AoCSolution
  def solution
    read_robot_positions_and_velocity
    100.times { move_robots }
    safety_factor
  end

  protected

  def read_robot_positions_and_velocity
    @robot_positions_and_velocity = []
    input_lines.each do |line|
      @robot_positions_and_velocity << parse(line)
    end
  end

  def width = 101
  def height = 103

  def build_robot(match)
    {
      position: {
        x: match[1].strip.to_i,
        y: match[2].strip.to_i
      },
      velocity: {
        x: match[3].strip.to_i,
        y: match[4].strip.to_i
      }
    }
  end

  def parse(line)
    line.match(/p=(.+),(.+) v=(.+),(.+)/) { |m| build_robot(m) }
  end

  def update_robot_position(robot)
    robot[:position][:x] += robot[:velocity][:x]
    robot[:position][:y] += robot[:velocity][:y]

    robot[:position][:x] %= width
    robot[:position][:y] %= height
  end

  def move_robots
    @robot_positions_and_velocity.each do |robot|
      update_robot_position(robot)
    end
  end

  def find_quadrant(pos_x, pos_y)
    x_half = width / 2
    y_half = height / 2

    if pos_x < x_half
      return 0 if pos_y < y_half

      2 if pos_y > y_half
    elsif pos_x > x_half
      return 1 if pos_y < y_half

      3 if pos_y > y_half
    end
  end

  def safety_factor
    quadrants = [0, 0, 0, 0]

    @robot_positions_and_velocity.each do |robot|
      x = robot[:position][:x]
      y = robot[:position][:y]

      quadrant = find_quadrant(x, y)
      quadrants[quadrant] += 1 if quadrant
    end

    quadrants.reduce(:*)
  end
end

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

  def parse(line)
    line.match(/p=(.+),(.+) v=(.+),(.+)/) do |m|
      {
        position: {
          x: m[1].strip.to_i,
          y: m[2].strip.to_i
        },
        velocity: {
          x: m[3].strip.to_i,
          y: m[4].strip.to_i
        }
      }
    end
  end

  def move_robots
    @robot_positions_and_velocity.each do |robot|
      robot[:position][:x] += robot[:velocity][:x]
      robot[:position][:y] += robot[:velocity][:y]

      robot[:position][:x] %= width
      robot[:position][:y] %= height
    end
  end

  def safety_factor
    quadrants = [0, 0, 0, 0]

    @robot_positions_and_velocity.each do |robot|
      if robot[:position][:x] < width / 2 && robot[:position][:y] < height / 2
        quadrants[0] += 1
      elsif robot[:position][:x] > width / 2 && robot[:position][:y] < height / 2
        quadrants[1] += 1
      elsif robot[:position][:x] < width / 2 && robot[:position][:y] > height / 2
        quadrants[2] += 1
      elsif robot[:position][:x] > width / 2 && robot[:position][:y] > height / 2
        quadrants[3] += 1
      end
    end

    quadrants.reduce(:*)
  end
end

# frozen_string_literal: true

require 'aoc_support'
require_relative 'part1_input_parser'

class Day15Part1 < AoCSolution
  include Constants

  class << self
    def get_new_position(position, direction)
      offset = Constants::OFFSETS[direction]

      Struct.new(:x, :y).new(position.x + offset[0], position.y + offset[1])
    end
  end

  attr_reader :map, :movements, :robot_position

  def solution
    read_map_and_movements
    visualize_map if debug?
    predict_robot_movement
    visualize_map if debug?
    gps_coordinate
  end

  protected

  def debug? = false

  def trace? = false

  def box_element = BOX_CELL

  def read_map_and_movements
    @map, @movements, @robot_position = Part1InputParser.parse(input_lines)
  end

  def visualize_map
    @map.each do |row|
      puts(row.join)
    end
  end

  def predict_robot_movement
    @movements.each do |direction|
      if trace?
        puts
        puts("Trying to move robot #{direction}")
      end

      binding.pry if debug? # rubocop:disable Lint/Debugger
      try_move_robot(direction)

      visualize_map if trace?
    end
  end

  def try_move_robot(direction)
    new_robot_position = get_new_position(@robot_position, direction)
    attempt_result = movement_possible?(new_robot_position, direction)
    move_robot(direction) if attempt_result
    attempt_result
  end

  def move_robot(direction)
    new_position = get_new_position(@robot_position, direction)
    @map[@robot_position.y][@robot_position.x] = EMPTY_CELL
    @map[new_position.y][new_position.x] = ROBOT_CELL
    @robot_position = new_position
  end

  def try_move_box_at(position, direction)
    new_box_position = get_new_position(position, direction)
    attemp_result = movement_possible?(new_box_position, direction)
    move_box_at(position, direction) if attemp_result
    attemp_result
  end

  def movement_possible?(position, direction)
    case get_map_element(position)
    when EMPTY_CELL
      true
    when BOX_CELL
      try_move_box_at(position, direction)
    when WALL_CELL
      false
    else
      raise "Unknown map element: #{get_map_element(position)}"
    end
  end

  def move_box_at(position, offset)
    new_box_position = get_new_position(position, offset)
    @map[position.y][position.x] = EMPTY_CELL
    @map[new_box_position.y][new_box_position.x] = BOX_CELL
  end

  def get_new_position(position, direction)
    self.class.get_new_position(position, direction)
  end

  def get_map_element(position)
    @map[position.y][position.x]
  end

  def gps_coordinate
    total = 0
    @map.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        total += (y * 100) + x if cell == box_element
      end
    end

    total
  end
end

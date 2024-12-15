# frozen_string_literal: true

require 'aoc_support'
require_relative 'part2_input_parser'

class Day15Part2 < Day15Part1
  LOOK_AHEAD_OFFSETS = {
    [BOX_END_CELL, EMPTY_CELL] => ->(position) { [get_new_position(position, LEFT)] },
    [EMPTY_CELL, BOX_START_CELL] => ->(position) { [get_new_position(position, RIGHT)] },
    [BOX_END_CELL, BOX_START_CELL] => lambda { |position|
      [get_new_position(position, LEFT),
       get_new_position(position, RIGHT)]
    },
    [BOX_START_CELL, BOX_END_CELL] => ->(position) { [position] }
  }.freeze

  attr_reader :map, :movements, :robot_position

  protected

  def box_element = BOX_START_CELL

  def read_map_and_movements
    @map, @movements, @robot_position = Part2InputParser.parse(input_lines)
  end

  def try_move_robot(direction)
    new_robot_position = get_new_position(@robot_position, direction)
    attempt_result = robot_movement_possible?(new_robot_position, direction)
    move_robot(direction) if attempt_result
    attempt_result
  end

  def try_move_box_at(position, direction)
    unless get_map_element(position) == BOX_START_CELL
      raise "Expected box starting position, got #{get_map_element(position)}"
    end

    attemp_result = box_movement_possible?(position, direction)
    move_box_at(position, direction) if attemp_result
    attemp_result
  end

  def box_movement_possible?(current_position, direction)
    new_position = get_new_position(current_position, direction)
    with_box_movement(current_position, current_position) do
      area = get_area_around(new_position)
      next true if area == [EMPTY_CELL, EMPTY_CELL]

      LOOK_AHEAD_OFFSETS[area]&.call(new_position)&.all? do |look_ahead_position|
        box_movement_possible?(look_ahead_position, direction)
      end || false
    end
  end

  def mark_map_empty(pos)
    @map[pos.y][pos.x..pos.x + 1] = [EMPTY_CELL, EMPTY_CELL]
  end

  def mark_map_box(pos)
    @map[pos.y][pos.x..pos.x + 1] = [BOX_START_CELL, BOX_END_CELL]
  end

  def get_area_around(position)
    [get_map_element(position), get_map_element(get_new_position(position, RIGHT))]
  end

  def robot_movement_possible?(position, direction)
    movements = {
      EMPTY_CELL => ->(_, _) { true },
      BOX_START_CELL => ->(pos, dir) { try_move_box_at(pos, dir) },
      BOX_END_CELL => ->(pos, dir) { try_move_box_at(get_new_position(pos, LEFT), dir) },
      WALL_CELL => ->(_, _) { false }
    }

    map_element = get_map_element(position)
    raise "Unknown map element: #{map_element}" unless movements.key?(map_element)

    movements[map_element].call(position, direction)
  end

  def with_box_movement(old_position, new_position)
    mark_map_empty(old_position)
    result = yield
    mark_map_box(new_position)
    result
  end

  def move_box_at(position, direction)
    new_position = get_new_position(position, direction)
    with_box_movement(position, new_position) do
      area = get_area_around(new_position)
      look_ahead = LOOK_AHEAD_OFFSETS[area]&.call(new_position)
      look_ahead&.each do |look_ahead_position|
        move_box_at(look_ahead_position, direction)
      end
    end
  end
end

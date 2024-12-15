# frozen_string_literal: true

require 'aoc_support'

# rubocop:disable Metrics/ClassLength
class Day15Part2 < Day15Part1
  attr_reader :map, :movements, :robot_position

  def solution
    read_map_and_movements
    visualize_map
    predict_robot_movement
    visualize_map
    gps_coordinate
  end

  protected

  def debug?
    false
  end

  def trace?
    false
  end

  def parse_map(map_group)
    map_group.map do |line|
      line
        .chomp
        .chars
        .map do |element|
          new_map_element(element)
        end
        .flatten
    end
  end

  def new_map_element(element)
    new_map_elements = {
      '#' => ['#', '#'],
      'O' => ['[', ']'],
      '@' => ['@', '.'],
      '.' => ['.', '.']
    }
    new_map_elements[element]
  end

  def try_move_robot(direction)
    new_robot_position = get_new_position(@robot_position, direction)
    attempt_result = robot_movement_possible?(new_robot_position, direction)
    move_robot(direction) if attempt_result
    attempt_result
  end

  def try_move_box_at(position, direction)
    raise "Expected box starting position, got #{get_map_element(position)}" unless get_map_element(position) == '['

    attemp_result = box_movement_possible?(position, direction)
    move_box_at(position, direction) if attemp_result
    attemp_result
  end

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/MethodLength
  def box_movement_possible?(current_position, direction)
    new_position = get_new_position(current_position, direction)
    mark_map_empty(current_position)
    result = case get_area_around(new_position)
             when '..'
               true
             when '.#', '#.', '##'
               false
             when '].'
               box_movement_possible?(get_new_position(new_position, '<'), direction)
             when '.['
               box_movement_possible?(get_new_position(new_position, '>'), direction)
             when ']['
               box_movement_possible?(get_new_position(new_position, '<'), direction) &&
               box_movement_possible?(get_new_position(new_position, '>'), direction)
             when '[]'
               box_movement_possible?(new_position, direction)
             end

    mark_map_box(current_position)
    result
  end
  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/MethodLength

  def mark_map_empty(pos)
    @map[pos.y][pos.x] = '.'
    @map[pos.y][pos.x + 1] = '.'
  end

  def mark_map_box(pos)
    @map[pos.y][pos.x] = '['
    @map[pos.y][pos.x + 1] = ']'
  end

  def get_area_around(position)
    [get_map_element(position), get_map_element(get_new_position(position, '>'))].join
  end

  def robot_movement_possible?(position, direction)
    movements = {
      '.' => ->(_, _) { true },
      '[' => ->(pos, dir) { try_move_box_at(pos, dir) },
      ']' => ->(pos, dir) { try_move_box_at(get_new_position(pos, '<'), dir) },
      '#' => ->(_, _) { false }
    }

    map_element = get_map_element(position)
    raise "Unknown map element: #{map_element}" unless movements.key?(map_element)

    movements[map_element].call(position, direction)
  end

  # rubocop:disable Metrics/MethodLength
  def move_box_at(position, offset)
    new_position = get_new_position(position, offset)
    mark_map_empty(position)
    case get_area_around(new_position)
    when '].'
      move_box_at(get_new_position(new_position, '<'), offset)
    when '.['
      move_box_at(get_new_position(new_position, '>'), offset)
    when ']['
      move_box_at(get_new_position(new_position, '<'), offset)
      move_box_at(get_new_position(new_position, '>'), offset)
    when '[]'
      move_box_at(new_position, offset)
    end

    mark_map_box(new_position)
  end
  # rubocop:enable Metrics/MethodLength

  def gps_coordinate
    total = 0
    @map.each_with_index do |row, y|
      row.each_with_index do |element, x|
        total += (y * 100) + x if element == '['
      end
    end

    total
  end
end
# rubocop:enable Metrics/ClassLength

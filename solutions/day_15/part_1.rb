# frozen_string_literal: true

require 'aoc_support'

# rubocop:disable Metrics/ClassLength
class Day15Part1 < AoCSolution
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

  def read_map_and_movements
    map_group, movements_group = input_lines.slice_when { |_line1, line2| line2.chomp.empty? }.to_a
    @map = parse_map(map_group)
    @movements = parse_movements(movements_group)
    @robot_position = find_robot_position
  end

  def parse_map(map_group)
    map_group.map do |line|
      line.chomp.chars
    end
  end

  def parse_movements(movements_group)
    movements_group.map do |line|
      line.chomp.chars
    end.flatten
  end

  def find_robot_position
    Struct.new(:x, :y).new.tap do |position|
      @map.find_index { |row| row.include?('@') }.tap do |y|
        position.y = y
        position.x = @map[y].find_index('@')
      end
    end
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
    @map[@robot_position.y][@robot_position.x] = '.'
    @map[new_position.y][new_position.x] = '@'
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
    when '.'
      true
    when 'O'
      try_move_box_at(position, direction)
    when '#'
      false
    else
      raise "Unknown map element: #{get_map_element(position)}"
    end
  end

  def move_box_at(position, offset)
    new_box_position = get_new_position(position, offset)
    @map[position.y][position.x] = '.'
    @map[new_box_position.y][new_box_position.x] = 'O'
  end

  def get_new_position(position, direction)
    offsets = {
      '^' => [0, -1],
      'v' => [0, 1],
      '<' => [-1, 0],
      '>' => [1, 0]
    }

    offset = offsets[direction]

    Struct.new(:x, :y).new(position.x + offset[0], position.y + offset[1])
  end

  def get_map_element(position)
    @map[position.y][position.x]
  end

  def gps_coordinate
    total = 0
    @map.each_with_index do |row, y|
      row.each_with_index do |element, x|
        total += (y * 100) + x if element == 'O'
      end
    end

    total
  end
end
# rubocop:enable Metrics/ClassLength

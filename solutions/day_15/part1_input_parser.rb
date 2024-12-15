# frozen_string_literal: true

require_relative 'constants'

class Part1InputParser
  extend Constants

  class << self
    def parse(input_lines)
      map_group, movements_group = input_lines.slice_when { |_line1, line2| line2.empty? }.to_a
      map = parse_map(map_group)
      movements = parse_movements(movements_group)
      robot_position = find_robot_position(map)

      [map, movements, robot_position]
    end

    protected

    def parse_map(map_group)
      map_group.map(&:chars)
    end

    def parse_movements(movements_group)
      movements_group.reject(&:empty?).map(&:chars).flatten
    end

    def find_robot_position(map)
      Struct.new(:x, :y).new.tap do |position|
        map.find_index { |row| row.include?(ROBOT_CELL) }.tap do |y|
          position.y = y
          position.x = map[y].find_index(ROBOT_CELL)
        end
      end
    end
  end
end

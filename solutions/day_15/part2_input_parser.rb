# frozen_string_literal: true

require_relative 'constants'

class Part2InputParser < Part1InputParser
  extend Constants

  class << self
    NEW_MAP_ELEMENTS = {
      WALL_CELL => [WALL_CELL, WALL_CELL],
      BOX_CELL => [BOX_START_CELL, BOX_END_CELL],
      ROBOT_CELL => [ROBOT_CELL, EMPTY_CELL],
      EMPTY_CELL => [EMPTY_CELL, EMPTY_CELL]
    }.freeze

    protected

    def parse_map(map_group)
      map_group.map do |line|
        line
          .chars
          .map { |element| NEW_MAP_ELEMENTS[element] }
          .flatten
      end
    end
  end
end

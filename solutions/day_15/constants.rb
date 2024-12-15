# frozen_string_literal: true

module Constants
  LEFT = '<'
  RIGHT = '>'
  UP = '^'
  DOWN = 'v'

  ROBOT_CELL = '@'
  EMPTY_CELL = '.'
  WALL_CELL = '#'
  BOX_CELL = 'O'

  BOX_START_CELL = '['
  BOX_END_CELL = ']'

  OFFSETS = {
    UP => [0, -1],
    DOWN => [0, 1],
    LEFT => [-1, 0],
    RIGHT => [1, 0]
  }.freeze
end

# frozen_string_literal: true

require 'aoc_support'

class Day13Part1 < AoCSolution
  def solution
    read_machine_configuration
    cheapest_to_win_all
  end

  protected

  def read_machine_configuration
    current_machine = Struct.new(:button_a, :button_b, :prize).new

    @machines = []
    input_lines.each do |line|
      if line.start_with?('Button A:')
        current_machine.button_a = get_coordinates(line)
      elsif line.start_with?('Button B:')
        current_machine.button_b = get_coordinates(line)
      elsif line.start_with?('Prize:')
        current_machine.prize = get_coordinates(line)
        @machines << current_machine
        current_machine = Struct.new(:button_a, :button_b, :prize).new
      else
        next
      end
    end
  end

  def get_coordinates(line)
    coordinates = Struct.new(:x, :y).new
    line.match(/X[\+\=](\d+), Y[\+\=](\d+)/) do |match|
      coordinates.x = match[1].strip.to_i
      coordinates.y = match[2].strip.to_i
    end

    coordinates
  end

  def cheapest_to_win(machine)
    ax = machine.button_a.x
    ay = machine.button_a.y
    bx = machine.button_b.x
    by = machine.button_b.y
    px = machine.prize.x
    py = machine.prize.y

    a = ((px * by) - (py * bx)) / ((ax * by) - (ay * bx))
    b = ((ax * py) - (ay * px)) / ((ax * by) - (ay * bx))

    if (a * ax) + (b * bx) == px && (a * ay) + (b * by) == py
      (3 * a) + b
    else
      0
    end
  end

  def cheapest_to_win_all
    @machines.map { |machine| cheapest_to_win(machine) }.sum
  end
end

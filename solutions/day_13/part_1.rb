# frozen_string_literal: true

require 'aoc_support'

class Day13Part1 < AoCSolution
  def solution
    read_machine_configuration
    cheapest_to_win_all
  end

  protected

  def read_machine_configuration
    @machines = input_lines.slice_when { |line, _| line.empty? }.map do |machine_lines|
      parse_machine(machine_lines)
    end
  end

  def parse_machine(machine_lines)
    Struct.new(:button_a, :button_b, :prize).new.tap do |machine|
      machine_lines.each do |line|
        machine.button_a = get_coordinates(line) if line.start_with?('Button A:')
        machine.button_b = get_coordinates(line) if line.start_with?('Button B:')
        machine.prize = get_coordinates(line) if line.start_with?('Prize:')
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

  def calc_denominator(machine)
    machine.button_a => { x: ax, y: ay }
    machine.button_b => { x: bx, y: by}
    ((ax * by) - (ay * bx))
  end

  def calc_numberators(machine)
    machine.button_a => { x: ax, y: ay }
    machine.button_b => { x: bx, y: by}
    machine.prize => { x: px, y: py }

    [(px * by) - (py * bx), (ax * py) - (ay * px)]
  end

  def win?(machine, part_a, part_b)
    machine.button_a => { x: ax, y: ay }
    machine.button_b => { x: bx, y: by}
    machine.prize => { x: px, y: py }

    (part_a * ax) + (part_b * bx) == px && (part_a * ay) + (part_b * by) == py
  end

  def cheapest_to_win(machine)
    denominator = calc_denominator(machine)
    a, b = calc_numberators(machine).map { |numerator| numerator / denominator }

    if win?(machine, a, b)
      (3 * a) + b
    else
      0
    end
  end

  def cheapest_to_win_all
    @machines.map { |machine| cheapest_to_win(machine) }.sum
  end
end

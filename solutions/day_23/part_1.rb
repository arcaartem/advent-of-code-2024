# frozen_string_literal: true

require 'aoc_support'

class Day23Part1 < AoCSolution
  def solution
    read_connections
    find_sets_of_three
    narrow_down('t').count
  end

  protected

  def read_connections
    all_connections = input_lines.map do |line|
      line.split('-')
    end

    @connections = {}

    all_connections.each do |(con1, con2)|
      assign_connections(con1, con2)
    end

    @computers = Set.new(@connections.keys)
  end

  def assign_connections(con1, con2)
    @connections[con1] ||= Set.new
    @connections[con2] ||= Set.new

    @connections[con1] << con2
    @connections[con2] << con1
  end

  def find_sets_of_three
    @sets_of_three = []

    @computers.to_a.combination(3).each do |(con1, con2, con3)|
      next unless @connections[con1].include?(con2) &&
                  @connections[con2].include?(con3) &&
                  @connections[con3].include?(con1)

      @sets_of_three << [con1, con2, con3]
    end
  end

  def narrow_down(starts_with)
    @sets_of_three.select do |set|
      set.any? { |comp| comp.start_with?(starts_with) }
    end
  end
end

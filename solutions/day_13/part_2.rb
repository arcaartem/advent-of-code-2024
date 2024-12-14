# frozen_string_literal: true

require 'aoc_support'

class Day13Part2 < Day13Part1
  def solution
    read_machine_configuration
    fix_prize_positions
    cheapest_to_win_all
  end

  protected

  def fix_prize_positions
    @machines.each do |machine|
      machine.prize.x += 10_000_000_000_000
      machine.prize.y += 10_000_000_000_000
    end
  end
end

# frozen_string_literal: true

require 'aoc_support'

class Day5Part1 < AoCSolution
  attr_reader :rules, :updates

  def solution
    read_rules_and_updates
    sum_middle_pages_of_correctly_ordered_updates
  end

  protected

  def read_rules_and_updates
    @rules = []
    @updates = []

    input_lines.each do |line|
      if line.include?('|')
        parse_rule(line)
      elsif line.include?(',')
        parse_update(line)
      end
    end
  end

  def sum_middle_pages_of_correctly_ordered_updates
    updates
      .filter(&method(:correctly_ordered?))
      .map(&method(:middle_page))
      .sum
  end

  def parse_rule(line)
    before, after = line.split('|').map(&:to_i)
    rules << [before, after]
  end

  def parse_update(line)
    parts = line.split(',').map(&:to_i)
    updates << parts
  end

  def correctly_ordered?(update)
    rules.each do |before, after|
      next unless update.include?(before)
      next unless update.include?(after)

      return false unless update.index(before) < update.index(after)
    end
    true
  end

  def middle_page(update)
    index = (update.length / 2)
    update[index]
  end
end

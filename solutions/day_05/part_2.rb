# frozen_string_literal: true

require 'aoc_support'

class Day5Part2 < Day5Part1
  attr_reader :rules, :updates

  def solution
    read_rules_and_updates
    sum_middle_pages_of_corrected_updates
  end

  protected

  def sum_middle_pages_of_corrected_updates
    updates
      .filter(&method(:incorrectly_ordered?))
      .map(&method(:order_update))
      .map(&method(:middle_page))
      .sum
  end

  def incorrectly_ordered?(update)
    !correctly_ordered?(update)
  end

  def order_update(update)
    update.sort { |left, right| rule_check(left, right) }
  end

  def rule_check(left, right)
    return 0 if left == right

    rules.each do |before, after|
      return -1 if left == before && right == after
      return 1 if left == after && right == before
    end
    -1
  end
end

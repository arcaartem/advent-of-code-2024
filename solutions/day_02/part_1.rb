# frozen_string_literal: true

require 'aoc_support'

class Day2Part1 < AoCSolution
  def solution
    read_reports
    count_safe_reports
  end

  private

  def read_reports
    @reports = input_lines.map { |line| line.split.map(&:to_i) }
  end

  def count_safe_reports
    @reports.count do |report|
      (all_increasing?(report) || all_decreasing?(report)) && elements_differ_by(report, 1, 3)
    end
  end

  def all_increasing?(report)
    report.each_cons(2).all? { |a, b| a <= b }
  end

  def all_decreasing?(report)
    report.each_cons(2).all? { |a, b| a >= b }
  end

  def elements_differ_by(report, min, max)
    report.each_cons(2).all? { |x, y| (x - y).abs >= min && (x - y).abs <= max }
  end
end

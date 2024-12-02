# frozen_string_literal: true

require 'aoc_support'

class Day2Part2 < AoCSolution
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
      report_permutations(report).find { |perm| safe_report?(perm) }
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

  def safe_report?(report)
    (all_increasing?(report) || all_decreasing?(report)) && elements_differ_by(report, 1, 3)
  end

  def report_permutations(report)
    Enumerator.new do |yielder|
      yielder << report
      report.length.times do |i|
        new_report = report.dup
        new_report.delete_at(i)
        yielder << new_report
      end
    end
  end
end

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
    counter = 0
    @reports.each do |report|
      if safe_report?(report)
        counter += 1
        next
      end

      for i in 0...report.length
        new_report = report.dup
        new_report.delete_at(i)
        if safe_report?(new_report)
          counter += 1
          break
        end
      end
    end
    counter
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
end

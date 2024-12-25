# frozen_string_literal: true

require 'aoc_support'

class Day25Part1 < AoCSolution
  def solution
    read_schematics
    count_lock_key_pairs
  end

  protected

  def read_schematics
    schematics = input_lines.slice_when { |line, _| line.empty? }.map { |schematic| schematic.reject(&:empty?) }

    lock_schematics, key_schematics = schematics.partition { |schematic| schematic.first == '#####' }

    @locks = lock_schematics.map { |schematic| parse_lock_schematic(schematic) }
    @keys = key_schematics.map { |schematic| parse_key_schematic(schematic) }
  end

  def parse_lock_schematic(schematic)
    schematic.map(&:chars).transpose.map do |line|
      line.count('#') - 1
    end
  end

  def parse_key_schematic(schematic)
    schematic.reverse.map(&:chars).transpose.map do |line|
      line.count('#') - 1
    end
  end

  def count_lock_key_pairs
    @matching_pairs = Set.new

    @locks.each do |lock|
      @keys.each do |key|
        @matching_pairs << [lock, key] if all_columns_fit?(lock, key)
      end
    end

    @matching_pairs.size
  end

  def all_columns_fit?(lock, key)
    lock.zip(key).all? do |lock_column, key_column|
      lock_column + key_column <= 5
    end
  end
end

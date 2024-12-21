# frozen_string_literal: true

require 'aoc_support'
require_relative 'dfs'

class Day21Part1 < AoCSolution
  NUMERIC_KEYPAD = [
    ['7', '8', '9'],
    ['4', '5', '6'],
    ['1', '2', '3'],
    [' ', '0', 'A']
  ].freeze

  DIRECTIONAL_KEYPAD = [
    [' ', '^', 'A'],
    ['<', 'v', '>']
  ].freeze

  def solution
    read_door_codes
    find_all_sequence_sets
    calculate_complexity
  end

  protected

  def prune_paths(all_paths)
    pruned_paths = []
    min_length = all_paths.min_by(&:length).length
    all_paths.each do |path|
      pruned_paths << path if path.length == min_length
    end
    pruned_paths
  end

  def read_door_codes
    @door_codes = input_lines.map(&:chars)
  end

  def find_all_sequence_sets
    @all_sequences = []
    @door_codes.each do |door_code|
      @all_sequences << find_min_sequence_set(door_code)
    end
  end

  def find_min_sequence_set(door_code)
    level1 = find_sequences(door_code, NUMERIC_KEYPAD)

    level2 = level1.map do |sequence|
      find_sequences(sequence.chars, DIRECTIONAL_KEYPAD)
    end.flatten(1)
    level3 = prune_paths(level2).map do |sequence|
      find_sequences(sequence.chars, DIRECTIONAL_KEYPAD)
    end.flatten(1)
    prune_paths(level3).min_by(&:length)
  end

  def find_sequences(door_code, pad)
    all_sequences = []
    current_pos = find_key_position('A', pad)
    door_code.each do |key|
      next_pos = find_key_position(key, pad)
      paths = DFS.find_all_paths(pad, current_pos, next_pos)
      paths.map(&:join)
      all_sequences << prune_paths(paths)
      current_pos = next_pos
    end
    combinations_of(all_sequences)
  end

  def combinations_of(sequence_sets)
    return sequence_sets[0] if sequence_sets.length == 1

    sequence_sets[0].map do |sequence|
      combinations_of(sequence_sets[1..]).map do |sub_sequence|
        [sequence, sub_sequence].join
      end
    end.flatten
  end

  def calculate_complexity
    @all_sequences.map.with_index do |sequence_set, index|
      min_length = sequence_set.length
      numeric_code = @door_codes[index].grep(/\d/).join.to_i
      min_length * numeric_code
    end.sum
  end

  def find_key_position(key, pad)
    @key_positions ||= {}
    @key_positions[pad] ||= pad.map.with_index do |row, row_index|
      row.map.with_index do |col, col_index|
        [col, [col_index, row_index]]
      end
    end.flatten(1).to_h.freeze
    @key_positions[pad][key]
  end
end

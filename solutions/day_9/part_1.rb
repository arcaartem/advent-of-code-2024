# frozen_string_literal: true

require 'aoc_support'

class Day9Part1 < AoCSolution
  attr_reader :disk

  def solution
    read_disk_map
    visualize_disk
    compact_disk
    visualize_disk
    checksum_disk
  end

  protected

  def debug?
    false
  end

  def read_disk_map
    disk_map_dense = input_text.chomp.chars.map(&:to_i)

    @disk = []
    disk_map_dense.each_with_index do |block_length, index|
      file = index.even? ? index / 2 : -1
      @disk += [file] * block_length
    end
  end

  def visualize_disk
    return unless debug?

    puts
    puts('Disk visualization: ')

    @disk.each do |block|
      print(block.negative? ? '.' : block)
    end

    puts
  end

  def compact_disk
    read_index = disk.length - 1
    write_index = 0

    while write_index < read_index
      if disk[read_index].negative?
        read_index -= 1
        next
      end

      if disk[write_index].negative?
        disk[write_index] = disk[read_index]
        disk[read_index] = -1
        read_index -= 1
      end

      write_index += 1
    end
  end

  def checksum_disk
    disk.map.with_index { |b, i| b.negative? ? 0 : b * i }.sum
  end
end

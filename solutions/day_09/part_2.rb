# frozen_string_literal: true

require 'aoc_support'

class Day9Part2 < Day9Part1
  def solution
    read_disk_map
    build_disk_index
    visualize_disk
    compact_disk
    visualize_disk
    checksum_disk
  end

  protected

  def visualize_disk
    return unless debug?

    super
    visualize_index
  end

  def visualize_index
    puts('Index visualization: ')
    print('File index: ')
    p(@file_index)
    print('Empty block index: ')
    p(@empty_block_index)
  end

  def compact_disk
    current_file_id = last_file_id
    while current_file_id >= 0
      read_index, file_length = fetch_file_index(current_file_id)
      current_file_id -= 1

      write_index, empty_block_size = fetch_next_suitable_empty_block_index(file_length)

      next unless empty_block_size
      next if write_index.nil? || write_index > read_index

      move_file(read_index, write_index, file_length)
      update_empty_block_index(write_index, file_length, empty_block_size)
    end
  end

  def last_file_id
    disk.max
  end

  def fetch_file_index(file_id)
    @file_index[file_id]
  end

  def fetch_next_suitable_empty_block_index(file_length)
    suitable_block_sizes = @empty_block_index.keys.select { |block_size| block_size >= file_length }

    min_index = nil
    block_size_for_min_index = nil

    suitable_block_sizes.each do |block_size|
      index = @empty_block_index[block_size].min

      next if !min_index.nil? && index >= min_index

      min_index = index
      block_size_for_min_index = block_size
    end

    [min_index, block_size_for_min_index]
  end

  def update_empty_block_index(write_index, file_length, empty_block_size)
    @empty_block_index[empty_block_size].delete(write_index)
    remaining_empty_block_size = empty_block_size - file_length
    return unless remaining_empty_block_size.positive?

    @empty_block_index[remaining_empty_block_size] ||= []
    @empty_block_index[remaining_empty_block_size] << (write_index + file_length)
    @empty_block_index[remaining_empty_block_size].sort!
  end

  def build_disk_index
    clear_disk_index
    block_index = 0

    disk.slice_when { |a, b| a != b }.each do |block|
      if block.first.negative?
        add_empty_block_index(block, block_index)
      else
        add_file_index(block, block_index)
      end
      block_index += block.length
    end
  end

  def clear_disk_index
    @file_index = {}
    @empty_block_index = {}
  end

  def add_empty_block_index(block, block_index)
    empty_block_size = block.length
    @empty_block_index[empty_block_size] ||= []
    @empty_block_index[empty_block_size] << block_index
    @empty_block_index[empty_block_size].sort!
  end

  def add_file_index(block, block_index)
    file_id = block.first
    @file_index[file_id] = [block_index, block.length]
  end

  def move_file(read_index, write_index, file_length)
    disk[write_index, file_length] = disk[read_index, file_length]
    disk[read_index, file_length] = [-1] * file_length
  end
end

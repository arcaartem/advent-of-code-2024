# frozen_string_literal: true

class AntennaMapPresenter
  def initialize(antenna_map, antinodes)
    @antenna_map = antenna_map
    @antinodes = antinodes
  end

  def present_map
    @antenna_map
      .map
      .with_index do |row, row_index|
        present_row(row, row_index)
      end
      .join("\n")
  end

  private

  def present_row(row, row_index)
    row
      .map
      .with_index do |cell, col_index|
        present_cell(cell, row_index, col_index)
      end
      .join
  end

  def present_cell(cell, row_index, col_index)
    if cell == '.' && antinode_exists?(row_index, col_index)
      '#'
    else
      cell
    end
  end

  def antinode_exists?(row, col)
    @antinodes&.values&.any? do |positions|
      positions.include?([col, row])
    end
  end
end

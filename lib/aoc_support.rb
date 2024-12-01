# frozen_string_literal: true

class AoCSolution
  def initialize(input_filename: 'input.txt')
    @input_filename = input_filename
  end

  def solution = false

  protected

  def debug? = false

  def trace? = false

  def input_lines
    Enumerator.new do |yielder|
      File.open(input_file_path, 'r') do |f|
        f.each_line { |line| yielder << line.chomp }
      end
    end
  end

  def input_text
    File.read(input_file_path).chomp
  end

  private

  def input_file_path
    "#{File.dirname(caller_locations[1].path)}/#{@input_filename}"
  end
end

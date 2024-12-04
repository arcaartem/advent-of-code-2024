# frozen_string_literal: true

class AoCSolution
  def solution
    raise NotImplementedError, 'You must implement the solution method'
  end

  def input_lines
    Enumerator.new do |yielder|
      File.open(input_file_path, 'r') do |f|
        f.each_line { |line| yielder << line }
      end
    end
  end

  def input_text
    File.read(input_file_path)
  end

  private

  def input_file_path
    "#{File.dirname(caller_locations[1].path)}/input.txt"
  end
end

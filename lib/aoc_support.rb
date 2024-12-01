# frozen_string_literal: true

class AoCSolution
  def solution
    false
  end

  def input_lines
    Enumerator.new do |yielder|
      File.open(input_file, 'r') do |f|
        f.each_line { |line| yielder << line }
      end
    end
  end

  def input_text
    File.read(input_file)
  end

  private

  def input_file
    "#{File.dirname(caller_locations[1].path)}/input.txt"
  end
end

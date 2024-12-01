# frozen_string_literal: true

class AoCSolution
  def solution
    raise NotImplementedError, 'You must implement the solution method'
  end

  def input_lines
    input_file = "#{File.dirname(caller_locations.first.path)}/input.txt"

    Enumerator.new do |yielder|
      File.open(input_file, 'r') do |f|
        f.each_line do |line|
          yielder << line
        end
      end
    end
  end
end

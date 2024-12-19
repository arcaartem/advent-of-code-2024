# frozen_string_literal: true

class AoCSolution
  class << self
    @default_input_filename = 'input.txt'

    def input_from(filename)
      @default_input_filename = filename
    end
      
    def input_filename
      @default_input_filename
    end
  end

  def solution
    false
  end

  protected

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
  "#{File.dirname(caller_locations[1].path)}/#{@input_filename || self.class.input_filename}"
  end
end

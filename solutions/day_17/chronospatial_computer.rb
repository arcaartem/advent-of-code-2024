# frozen_string_literal: true

class ChronospatialComputer
  attr_accessor :ip, :reg_a, :reg_b, :reg_c
  attr_reader :instructions, :output_buffer

  def initialize(instructions, reg_a: 0, reg_b: 0, reg_c: 0, debug: false)
    @ip = 0
    @reg_a = reg_a
    @reg_b = reg_b
    @reg_c = reg_c
    @instructions = instructions
    @output_buffer = []
    @debug = debug
  end

  def execute
    step while ip < instructions.size
    output_buffer
  end

  def step
    opcode = instructions[ip]
    return if opcode.nil?

    operand = instructions[ip + 1]
    run_instruction(opcode, operand)

    @ip += 2
    show_state if debug?
    true
  end

  def reset(instructions, reg_a: 0)
    @ip = 0
    @reg_a = reg_a
    @reg_b = 0
    @reg_c = 0
    @instructions = instructions
    @output_buffer = []
  end

  def show_state
    puts "ip=#{ip} a=#{reg_a} b=#{reg_b} c=#{reg_c}"
    puts "instruction=#{instructions[ip]}, operand=#{instructions[ip + 1]}"
    puts "output_buffer=#{output_buffer}"
  end

  protected

  def debug?
    @debug
  end

  def compo_operand(operand)
    case operand
    when 0, 1, 2, 3
      operand
    when 4
      reg_a
    when 5
      reg_b
    when 6
      reg_c
    else
      raise 'Invalid operand'
    end
  end

  def run_instruction(opcode, operand)
    case opcode
    when 0
      adv(operand)
    when 1
      bxl(operand)
    when 2
      bst(operand)
    when 3
      jnz(operand)
    when 4
      bxc(operand)
    when 5
      out(operand)
    when 6
      bdv(operand)
    when 7
      cdv(operand)
    else
      raise 'Invalid opcode'
    end
  end

  def adv(operand)
    @reg_a = dv(operand)
  end

  def bxl(operand)
    @reg_b ^= operand
  end

  def bst(operand)
    @reg_b = compo_operand(operand) % 8
  end

  def jnz(operand)
    return if @reg_a.zero?

    @ip = operand - 2
  end

  def bxc(operand)
    @reg_b ^= reg_c
  end

  def out(operand)
    output_buffer << (compo_operand(operand) % 8)
  end

  def dv(operand)
    numerator = reg_a
    denominator = compo_operand(operand)
    numerator / (2**denominator)
  end

  def bdv(operand)
    @reg_b = dv(operand)
  end

  def cdv(operand)
    @reg_c = dv(operand)
  end
end

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
    operand = instructions[ip + 1]

    run_instruction(opcode, operand)

    @ip += 2

    show_state if debug?
  end

  def reset(instructions, reg_a: 0)
    @ip = 0
    @reg_a = reg_a
    @reg_b = 0
    @reg_c = 0
    @instructions = instructions
    @output_buffer = []
    self
  end

  def show_state
    puts "ip=#{ip} a=#{reg_a} b=#{reg_b} c=#{reg_c}"
    puts "instruction=#{instructions[ip]}, operand=#{instructions[ip + 1]}"
    puts "output_buffer=#{output_buffer}"
  end

  protected

  def debug? = @debug

  def compo_operand(operand)
    return operand if operand < 4
    raise 'Invalid operand' if operand > 6

    operand_values = [reg_a, reg_b, reg_c]
    operand_values[operand - 4]
  end

  # rubocop:disable Metrics/AbcSize
  def run_instruction(opcode, operand)
    [
      ->(op) { @reg_a = dv(op) }, # adv
      ->(op) { @reg_b ^= op }, # bxl
      ->(op) { @reg_b = compo_operand(op) % 8 }, # bst
      ->(op) { @ip = op - 2 unless @reg_a.zero? }, # jnz
      ->(_) { @reg_b ^= reg_c }, # bxc
      ->(op) { output_buffer << (compo_operand(op) % 8) }, # out
      ->(op) { @reg_b = dv(op) }, # bvd
      ->(op) { @reg_c = dv(op) } # cdv
    ][opcode].call(operand)
  end
  # rubocop:enable Metrics/AbcSize

  def dv(operand)
    numerator = reg_a
    denominator = compo_operand(operand)
    numerator / (2**denominator)
  end
end

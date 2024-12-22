# frozen_string_literal: true

require 'aoc_support'

class Day22Part1 < AoCSolution
  def solution
    read_initial_secrets
    2000.times { generate_new_secrets }
    sum_of_all_secret_numbers
  end

  protected

  def read_initial_secrets
    @secrets = input_lines.map(&:to_i)
  end

  def generate_new_secrets
    @secrets = @secrets.map { |secret| generate_new_secret(secret) }
  end

  def generate_new_secret(secret)
    secret = mix_and_prune(secret, secret * 64)
    secret = mix_and_prune(secret, secret / 32)
    mix_and_prune(secret, secret * 2048)
  end

  def mix_and_prune(old_secret, new_secret)
    new_secret ^= old_secret
    new_secret %= 16_777_216
    new_secret
  end

  def sum_of_all_secret_numbers
    @secrets.sum
  end
end

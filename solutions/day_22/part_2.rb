# frozen_string_literal: true

require 'aoc_support'

class Day22Part2 < Day22Part1
  def solution
    read_initial_secrets
    generate_prices
    generate_price_changes
    price_at_sequences
    max_bananas
  end

  protected

  def generate_prices
    @all_prices = Array.new(@secrets.length) { [] }
    2000.times do
      @secrets.each_with_index do |secret, buyer_index|
        @all_prices[buyer_index] << generate_price(secret)
      end
      generate_new_secrets
    end
  end

  def generate_price(secret)
    secret % 10
  end

  def generate_price_changes
    @all_price_changes = @all_prices.map do |buyer_prices|
      generate_price_change(buyer_prices)
    end
  end

  def generate_price_change(buyer_prices)
    buyer_prices.each_cons(2).map do |price_pair|
      (price_pair[1] - price_pair[0])
    end
  end

  def price_at_sequences
    available_buyers = Set.new
    all_sequences = Hash.new(0)

    @all_price_changes.each_with_index do |buyer_price_changes, buyer_index|
      price_index = 4
      buyer_price_changes.each_cons(4) do |sequence|
        all_sequences[sequence] += price_for(buyer_index, price_index) if available_buyers.add? [sequence, buyer_index]
        price_index += 1
      end
    end

    @all_sequences = all_sequences
  end

  def price_for(buyer_index, price_index) = @all_prices[buyer_index][price_index]

  def max_bananas = @all_sequences.values.max
end

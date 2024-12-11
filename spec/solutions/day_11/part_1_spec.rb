# frozen_string_literal: true

RSpec.describe Day11Part1 do
  let(:instance) { described_class.new }

  describe '#solution' do
    subject { instance.solution }

    it 'returns the correct answer' do
      expect(subject).to(eq(190_865))
    end
  end

  describe 'count digits' do
    let(:stone) { 1234 }

    it 'counts digits' do
      count = StoneSplitter.count_digits(stone)
      expect(count).to(eq(4))
    end
  end

  describe 'split stone' do
    let(:stone) { 1234 }

    it 'splits the stone into two stones' do
      left_stone, right_stone = StoneSplitter.split_stone(stone, 2)
      expect(left_stone).to(eq(12))
      expect(right_stone).to(eq(34))
    end
  end
end

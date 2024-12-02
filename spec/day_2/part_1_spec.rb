# frozen_string_literal: true

require_relative '../../solutions/day_2/part_1'

RSpec.describe Day2Part1 do
  let(:instance) { described_class.new }

  describe '#solution' do
    subject { instance.solution }

    it 'returns the correct answer' do
      expect(subject).to eq(407)
    end
  end
end

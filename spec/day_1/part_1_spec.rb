# frozen_string_literal: true

require_relative '../../solutions/day_1/part_1'

RSpec.describe Day1Part1 do
  let(:instance) { described_class.new }

  describe '#solution' do
    subject { instance.solution }

    it 'returns the correct answer' do
      expect(subject).to eq(2_031_679)
    end
  end
end

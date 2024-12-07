# frozen_string_literal: true

RSpec.describe Day7Part1 do
  let(:instance) { described_class.new }

  describe '#solution' do
    subject { instance.solution }

    it 'returns the correct answer' do
      expect(subject).to eq(12_553_187_650_171)
    end
  end
end

# frozen_string_literal: true

RSpec.describe Day6Part2 do
  let(:instance) { described_class.new }

  describe '#solution' do
    subject { instance.solution }

    it 'returns the correct answer' do
      expect(subject).to eq(1480)
    end
  end
end

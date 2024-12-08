# frozen_string_literal: true

RSpec.describe Day8Part1 do
  let(:instance) { described_class.new }

  describe '#solution' do
    subject { instance.solution }

    it 'returns the correct answer' do
      expect(subject).to eq(344)
    end
  end
end

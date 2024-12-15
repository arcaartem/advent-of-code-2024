# frozen_string_literal: true

RSpec.describe Day15Part1 do
  let(:instance) { described_class.new }

  describe '#solution' do
    subject { instance.solution }

    it 'returns the correct answer' do
      expect(subject).to(eq(1_511_865))
    end
  end
end

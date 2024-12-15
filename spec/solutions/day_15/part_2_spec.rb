# frozen_string_literal: true

RSpec.describe Day15Part2 do
  let(:instance) { described_class.new }

  describe '#solution' do
    subject { instance.solution }

    it 'returns the correct answer' do
      expect(subject).to(eq(1_519_991))
    end
  end
end

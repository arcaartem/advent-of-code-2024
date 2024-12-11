# frozen_string_literal: true

RSpec.describe Day11Part2 do
  let(:instance) { described_class.new }

  describe '#solution' do
    subject { instance.solution }

    it 'returns the correct answer' do
      expect(subject).to(eq(225_404_711_855_335))
    end
  end
end

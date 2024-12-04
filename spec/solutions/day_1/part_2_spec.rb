# frozen_string_literal: true

RSpec.describe Day1Part2 do
  let(:instance) { described_class.new }

  describe '#solution' do
    subject { instance.solution }

    it 'returns the correct answer' do
      expect(subject).to eq(19_678_534)
    end
  end
end

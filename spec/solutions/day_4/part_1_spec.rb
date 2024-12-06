# frozen_string_literal: true

RSpec.describe Day4Part1 do
  let(:instance) { described_class.new }

  describe '#solution' do
    subject { instance.solution }

    it 'returns the correct answer' do
      expect(subject).to eq(2401)
    end
  end
end

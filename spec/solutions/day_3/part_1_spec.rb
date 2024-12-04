# frozen_string_literal: true

RSpec.describe Day3Part1 do
  let(:instance) { described_class.new }

  describe '#solution' do
    subject { instance.solution }

    it 'returns the correct answer' do
      expect(subject).to eq(187_825_547)
    end
  end
end

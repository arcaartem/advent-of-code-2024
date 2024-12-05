# frozen_string_literal: true

RSpec.describe Day5Part2 do
  let(:instance) { described_class.new }

  describe '#solution' do
    subject { instance.solution }

    it 'returns the correct answer' do
      expect(subject).to eq(3062)
    end
  end
end

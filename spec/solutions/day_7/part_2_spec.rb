# frozen_string_literal: true

RSpec.describe Day7Part2 do
  let(:instance) { described_class.new }

  describe '#solution' do
    subject { instance.solution }

    it 'returns the correct answer' do
      expect(subject).to eq(96_779_702_119_491)
    end
  end
end

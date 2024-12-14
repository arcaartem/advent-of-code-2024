# frozen_string_literal: true

RSpec.describe Day13Part2 do
  let(:instance) { described_class.new }

  describe '#solution' do
    subject { instance.solution }

    it 'returns the correct answer' do
      expect(subject).to(eq(108_713_182_988_244))
    end
  end
end

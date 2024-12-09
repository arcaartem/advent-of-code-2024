# frozen_string_literal: true

RSpec.describe Day9Part1 do
  let(:instance) { described_class.new }

  describe '#solution' do
    subject { instance.solution }

    it 'returns the correct answer' do
      expect(subject).to(eq(6_337_921_897_505))
    end
  end
end

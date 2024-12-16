# frozen_string_literal: true

RSpec.describe Day16Part1 do
  let(:instance) { described_class.new }

  describe '#solution' do
    subject { instance.solution }

    it 'returns the correct answer' do
      expect(subject).to(eq(false))
    end
  end
end

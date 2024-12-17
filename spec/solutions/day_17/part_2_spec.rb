# frozen_string_literal: true

RSpec.describe Day17Part2 do
  let(:instance) { described_class.new }

  describe '#solution', :focus do
    subject { instance.solution }

    it 'returns the correct answer' do
      expect(subject).to(eq(265_061_364_597_659))
    end
  end
end

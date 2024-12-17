# frozen_string_literal: true

RSpec.describe Day17Part1 do
  let(:instance) { described_class.new }

  describe '#solution', :focus do
    subject { instance.solution }

    it 'returns the correct answer' do
      expect(subject).to(eq('1,4,6,1,6,4,3,0,3'))
    end
  end
end

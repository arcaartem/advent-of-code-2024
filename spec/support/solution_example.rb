# frozen_string_literal: true

RSpec.shared_examples 'a solution' do |for_input:, and_returns:|
  let(:instance) { described_class.new(input_filename: for_input) }

  describe "solution for '#{for_input}'" do
    subject { instance.solution }

    it 'returns the correct answer' do
      expect(subject).to(eq(and_returns))
    end
  end
end

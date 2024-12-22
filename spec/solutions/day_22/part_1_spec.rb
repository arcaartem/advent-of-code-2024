# frozen_string_literal: true

RSpec.describe Day22Part1 do
  it_behaves_like 'a solution', for_input: 'input-sample-1.txt', and_returns: 37_327_623
  it_behaves_like 'a solution', for_input: 'input.txt', and_returns: 19_822_877_190
end

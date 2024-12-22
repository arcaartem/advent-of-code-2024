# frozen_string_literal: true

RSpec.describe Day22Part2 do
  it_behaves_like 'a solution', for_input: 'input-sample-2.txt', and_returns: 23
  it_behaves_like 'a solution', for_input: 'input.txt', and_returns: 2277
end

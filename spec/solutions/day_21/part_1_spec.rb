# frozen_string_literal: true

RSpec.describe Day21Part1 do
  it_behaves_like 'a solution', for_input: 'input-sample-1.txt', and_returns: 126_384
  it_behaves_like 'a solution', for_input: 'input.txt', and_returns: 132_532
end

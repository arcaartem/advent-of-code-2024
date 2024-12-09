# frozen_string_literal: true

RSpec.describe Day9Part2 do
  it_behaves_like 'a solution', for_input: 'input-sample-1.txt', and_returns: 2858
  it_behaves_like 'a solution', for_input: 'input.txt', and_returns: 6_362_722_604_045
end

# frozen_string_literal: true

RSpec.describe Day25Part1 do
  it_behaves_like 'a solution', for_input: 'input-sample-1.txt', and_returns: 3
  it_behaves_like 'a solution', for_input: 'input.txt', and_returns: 3264
end

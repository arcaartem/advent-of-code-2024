# frozen_string_literal: true

RSpec.describe Day16Part1 do
  it_behaves_like 'a solution', for_input: 'input-sample-1.txt', and_returns: 7036
  it_behaves_like 'a solution', for_input: 'input-sample-2.txt', and_returns: 11_048
  it_behaves_like 'a solution', for_input: 'input.txt', and_returns: 133_584
end

# frozen_string_literal: true

RSpec.describe Day9Part1 do
  it_behaves_like 'a solution', for_input: 'input-sample-1.txt', and_returns: 1928
  it_behaves_like 'a solution', for_input: 'input.txt', and_returns: 6_337_921_897_505
end

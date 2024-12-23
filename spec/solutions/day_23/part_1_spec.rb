# frozen_string_literal: true

RSpec.describe Day23Part1 do
  it_behaves_like 'a solution', for_input: 'input-sample-1.txt', and_returns: 7
  it_behaves_like 'a solution', for_input: 'input.txt', and_returns: 1269
end

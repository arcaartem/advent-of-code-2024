# frozen_string_literal: true

RSpec.describe Day16Part2 do
  it_behaves_like 'a solution', for_input: 'input-sample-1.txt', and_returns: 45
  it_behaves_like 'a solution', for_input: 'input-sample-2.txt', and_returns: 64
  it_behaves_like 'a solution', for_input: 'input.txt', and_returns: 622
end

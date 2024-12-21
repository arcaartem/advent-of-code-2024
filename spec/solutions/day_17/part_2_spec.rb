# frozen_string_literal: true

RSpec.describe Day17Part2 do
  it_behaves_like 'a solution', for_input: 'input.txt-sample-2', and_returns: 117_440
  it_behaves_like 'a solution', for_input: 'input.txt', and_returns: 265_061_364_597_659
end

# frozen_string_literal: true

RSpec.describe Day17Part1 do
  it_behaves_like 'a solution', for_input: 'input.txt-sample-1', and_returns: '4,6,3,5,6,3,5,2,1,0'
  it_behaves_like 'a solution', for_input: 'input.txt', and_returns: '1,4,6,1,6,4,3,0,3'
end

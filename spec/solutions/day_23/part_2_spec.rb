# frozen_string_literal: true

RSpec.describe Day23Part2 do
  it_behaves_like 'a solution', for_input: 'input-sample-1.txt', and_returns: 'co,de,ka,ta'
  it_behaves_like 'a solution', for_input: 'input.txt', and_returns: 'ad,jw,kt,kz,mt,nc,nr,sb,so,tg,vs,wh,yh'
end

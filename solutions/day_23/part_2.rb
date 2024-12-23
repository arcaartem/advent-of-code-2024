# frozen_string_literal: true

require 'aoc_support'

class Day23Part2 < Day23Part1
  def solution
    read_connections
    find_largest_set
    extract_password
  end

  protected

  def find_largest_set
    @clique = []
    bron_kerbosch(Set.new, Set.new(@computers), Set.new)
  end

  # rubocop:disable Naming/MethodParameterName
  def bron_kerbosch(r, p, x)
    if p.empty? && x.empty?
      @clique = r if r.size > @clique.size
      return
    end

    p.each do |v|
      bron_kerbosch(r + [v], p & @connections[v], x & @connections[v])
      p -= [v]
      x += [v]
    end
  end
  # rubocop:enable Naming/MethodParameterName

  def extract_password
    @clique.sort.join(',')
  end
end

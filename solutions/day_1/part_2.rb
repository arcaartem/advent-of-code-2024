# frozen_string_literal: true

input = File.readlines('input.txt')
left = []
right = {}

input.each do |line|
  l, r = line.split
  left << l.to_i
  r = r.to_i
  if right.include?(r)
    right[r] += 1
  else
    right[r] = 1
  end
end

count = 0
left.each do |l|
  count += l * right[l] if right.include?(l)
end

p count

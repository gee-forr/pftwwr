#!/usr/bin/env ruby

my_rack_proc = lambda do |env|
  [200, {}, ["Hello. The time is #{Time.now}"]]
end

out = my_rack_proc.call({})
p out

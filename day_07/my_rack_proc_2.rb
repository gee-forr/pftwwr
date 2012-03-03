#!/usr/bin/env ruby

require 'rack'

my_rack_proc = lambda do |env|
  [200, {"Content-Type" => "text/plain"}, ["Hello. The time is #{Time.now}"]]
end

Rack::Server.new( {app: my_rack_proc, server: 'webrick', Port: 9876} ).start

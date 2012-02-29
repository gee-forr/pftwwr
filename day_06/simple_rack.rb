#!/usr/bin/env ruby

simple_rack = lambda do |env|
  [200, {}, ["Hello. The time is #{Time.now}"]]
end

environment = {
  'HTTP_METHOD'       => 'GET',
  'QUERY_STRING'      => "text=#{ARGV.first}",
  'SERVER_NAME'       => 'myserver.local',
  'SERVER_PORT'       => 80,
  'rack.version'      => [1,1],
  'rack.url_scheme'   => 'http',
  'rack.input'        => IO.new,
  'rack.errors'       => '',
  'rack.multithread'  => false,
  'rack.multiprocess' => false,
  'rack.run_once'     => true
}

response = simple_rack.call(environment)

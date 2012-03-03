#!/usr/bin/env ruby

simple_rack = lambda do |env|
  body = "Command line argument you typed was: #{env['QUERY_STRING'].scan(/=(.*)$/).first.first}"

  [200, {'Content-Type' => 'text/plain', 'Content-Length' => body.length}, [[body]]]
end

environment = {
  'HTTP_METHOD'       => 'GET',
  'QUERY_STRING'      => "text=#{ARGV.first}",
  'SERVER_NAME'       => 'myserver.local',
  'SERVER_PORT'       => 80,
  'rack.version'      => [1,1],
  'rack.url_scheme'   => 'http',
  'rack.input'        => '',
  'rack.errors'       => '',
  'rack.multithread'  => false,
  'rack.multiprocess' => false,
  'rack.run_once'     => true
}

response = simple_rack.call(environment)

puts response.first
response[1].each do |k, v|
  puts "#{k} => #{v}"
end
puts response.last.join

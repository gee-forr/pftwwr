#!/usr/bin/env ruby

require 'open-uri'
require 'net/http'
require 'hpricot'
require 'nokogiri'

uri     = 'http://satishtalim.github.com/webruby/chapter3.html'
word    = 'the'
regexp  = /\bthe\b/i
methods = {}

def scan_for_word(regexp)
  text = yield
  text.scan(regexp).count
end

# Net::HTTP
methods['Net::HTTP'] = scan_for_word(regexp) do
  url = URI.parse(uri)

  Net::HTTP.start(url.host, url.port) do |http|
    request              = Net::HTTP::Get.new(url.path)
    http.request(request).body
  end
end

# Open URI
methods['Open URI'] = scan_for_word(regexp) do
  open(uri).readlines.join
end

# Hpricot
methods['Hpricot'] = scan_for_word(regexp) do
  Hpricot(open uri).to_s
end

# Nokogiri 
methods['Nokogiri'] = scan_for_word(regexp) do
  Nokogiri::HTML(open uri).to_s
end

methods.each do |type, count|
  puts "#{type} found #{count} instances of the word '#{word}'"
end

#!/usr/bin/env ruby

require 'open-uri'
require 'net/http'
require 'hpricot'
require 'nokogiri'

uri     = 'http://satishtalim.github.com/webruby/chapter3.html'
word    = 'the'
regexp  = /\bthe\b/i
methods = {}

def scan_for_word(text, regexp)
  text.scan(regexp).count
end

# Net::HTTP
url = URI.parse(uri)

Net::HTTP.start(url.host, url.port) do |http|
  request              = Net::HTTP::Get.new(url.path)
  methods['Net::HTTP'] = scan_for_word(http.request(request).body, regexp)
end

# Open URI
uri_file            = open uri
methods['Open URI'] = scan_for_word(uri_file.readlines.join, regexp)

# Hpricot
hpricot_doc        = Hpricot(open uri)
methods['Hpricot'] = scan_for_word(hpricot_doc.to_s, regexp)

# Nokogiri 
noko_doc            = Nokogiri::HTML(open uri)
methods['Nokogiri'] = scan_for_word(noko_doc.to_s, regexp)

methods.each do |type, count|
  puts "#{type} found #{count} instances of the word '#{word}'"
end

#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'bundler/setup'
Bundler.require(:default)

require_relative 'lib/config'
require_relative 'lib/redis_connect'

if ARGV.length < 2
  puts "#{__FILE__} <event> <message>"
  exit
end

$redis.publish($config['redis']['channel'], {
  'event' => {
    'timestamp' => Time.now,
    'type' => ARGV[0],
    'message' => ARGV[1]
  }
}.to_json)

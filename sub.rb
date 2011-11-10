#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require 'json'

$redis = Redis.new(:host => '10.170.222.152', :port => 6379, :timeout => 0)

$redis.subscribe('sd') do |on|
  on.message do |channel, msg|
    data = JSON.parse(msg)
    puts "##{channel} - #{data['msg']}"
    `say #{data['msg']}`
  end
end

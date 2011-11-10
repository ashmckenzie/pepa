#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'bundler/setup'
Bundler.require(:default)

require_relative 'lib/config'
require_relative 'lib/redis_connect'

$redis.subscribe($config['redis']['channel']) do |on|
  on.message do |channel, msg|
    data = JSON.parse(msg)
    puts "##{channel} - #{data['msg']}"
  end
end

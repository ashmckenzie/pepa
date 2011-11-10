#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require 'json'

$redis = Redis.new(:host => '10.170.222.152', :port => 6379, :timeout => 0)

$redis.publish 'sd', { 'msg' => ARGV.join.strip }.to_json

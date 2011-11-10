#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'bundler/setup'
Bundler.require(:default)

require_relative 'lib/config'
require_relative 'lib/redis_connect'

$redis.publish($config['redis']['channel'], { 'msg' => ARGV.join.strip }.to_json)
#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'bundler/setup'
Bundler.require(:default)

require_relative 'lib/config'
require_relative 'lib/redis_connect'

event_types = [
  { :type => 'football_goal', :message => 'has scored a Goal' },
  { :type => 'football_goal_penalty', :message => 'has scored a Goal on penalty' },
  { :type => 'football_foul', :message => 'has committed a Foul' },
  { :type => 'football_red_card', :message => 'has received a Red card' },
  { :type => 'football_yellow_card', :message => 'has received a Yellow card' }
]

random_event_type = event_types.sample
event = { :type => random_event_type[:type], :message => Faker::Name.name + " " + random_event_type[:message] }

$redis.publish($config['redis']['channel'], {
  'event' => {
    'timestamp' => Time.now,
    'type' => event[:type],
    'message' => event[:message]
  }
}.to_json)
#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'bundler/setup'
Bundler.require(:default)

event_types = [
  { :type => 'football_goal', :message => 'has scored a Goal' },
  { :type => 'football_goal_penalty', :message => 'has scored a Goal on penalty' },
  { :type => 'football_foul', :message => 'has committed a Foul' },
  { :type => 'football_red_card', :message => 'has received a Red card' },
  { :type => 'football_yellow_card', :message => 'has received a Yellow card' }
]

random_event_type = event_types.sample
event = { :type => random_event_type[:type], :message => Faker::Name.name + " " + random_event_type[:message] }

`./pub.rb #{event[:type]} '#{event[:message]}'`

#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require 'json'
require 'yaml'
require 'active_support/all'

require_relative './lib/pepa_plugin_base'
require_relative './lib/sports_data_events'

$redis = Redis.new(:timeout => 0)
$config = YAML.load_file('./config.yaml')

Dir['./plugins/**/*.rb'].each do |file|
  require_relative file
end

bot = Cinch::Bot.new do
  configure do |c|
    c.nick = $config['nick']
    c.server = $config['server']
    c.channels = $config['rooms'].collect { |r| "\##{r}" }
    c.plugins.plugins = $config['plugins'].collect { |c| c.constantize }
  end
end

Thread.new { SportsDataEvents.new(bot).start }
bot.start

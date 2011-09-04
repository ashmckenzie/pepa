#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require 'yaml'
require 'active_support/all'

require_relative './lib/pepa_plugin_base'

$config = YAML.load_file('./config.yaml')

Dir['./plugins/**/*.rb'].each do |file|
  require_relative file
end

bot = Cinch::Bot.new do
  configure do |c|
    c.server = $config['server']
    c.channels = $config['rooms'].collect { |r| "\##{r}" }
    c.plugins.plugins = $config['plugins'].collect { |c| c.constantize }
  end
end

bot.start
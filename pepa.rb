#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'bundler/setup'
Bundler.require(:default)

require 'active_support/all'

require_relative 'lib/config'
require_relative 'lib/pepa'

Pepa.new.start
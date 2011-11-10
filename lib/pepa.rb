require_relative 'pepa_plugin_base'
require_relative 'sports_data_events'

class Pepa

	def initialize
		load_plugins
	end

	def start
		bot = Cinch::Bot.new do
		  configure do |c|
		    c.nick = $config['irc']['nick']
		    c.server = $config['irc']['host']
		    c.port = $config['irc']['port']
		    c.channels = $config['irc']['rooms'].collect { |r| "\##{r}" }
		    c.plugins.plugins = $config['irc']['plugins'].collect { |c| puts "Loading plugins #{c.constantize}"; c.constantize }
		  end
		end

		Thread.new { SportsDataEvents.new(bot).start }
		bot.start
	end

	private

	def load_plugins
		Dir[Pathname.new('plugins').expand_path.to_s + '/**/*.rb'].each do |file|
		  require file
		end
	end
end
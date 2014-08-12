require 'timeout'
require 'redis'
require 'json'

module GLO
		module LOG
			class Timeout < Exception; end
			autoload :Conn, File.join(File.dirname(__FILE__), 'glo-logging-server-client/conn')
			autoload :Client, File.join(File.dirname(__FILE__), 'glo-logging-server-client/client')
			autoload :Logger, File.join(File.dirname(__FILE__), 'glo-logging-server-client/logger')
		end
end

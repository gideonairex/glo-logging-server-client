module GLO::LOG
	class Client
		def initialize ( target, app )
			@conn = GLO::LOG::Conn.new( target, app )
		end
		def log ( log_level, msg, tag )
			@conn.log( log_level, msg, tag)
		end
	end
end

module GLO::LOG
	class Client
		def initialize ( app )
			@conn = GLO::LOG::Conn.new( app )
		end
		def log ( log_level, msg, tag )
			ts = Time.now
			@conn.log( log_level, msg, tag, ts )
		end
	end
end

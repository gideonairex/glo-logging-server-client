module GLO::LOG
	class Conn
		def initialize ( app )
			@redis = Redis.new
			@data = { 'app' => app }
		end
		def log ( log_level, msg, tag, ts )
			@redis.publish 'node', @data.merge( 'log_level' => log_level, 'msg' => msg, 'tag' => tag, 'time' => ts).to_json
		end
	end
end

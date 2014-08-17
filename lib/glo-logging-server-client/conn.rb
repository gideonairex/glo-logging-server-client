module GLO::LOG
	class Conn

		def initialize ( target, app )

			if target =~ /(.+)\:(\d+)$/i
				@host = $~[1]
				@port = $~[2]
			else
				@host = target
				@port = nil
			end

			@app = app
			@max_tries = 6
			@socket = nil
		end

		def log ( log_level ='debug' , msg = '' , tag = {})
			tries = 0
			connect( @host, @port )
			data = {'app' => @app, 'log_level' => log_level,'message'=>msg,'tag'=>tag}.to_json
			data_size = data.size.to_s
			begin
				write "*2\r\n$3\r\nLOG\r\n$"+data_size+"\r\n"+data+"\r\n"
			rescue Exception => e
				$stderr.puts "Failed to write to server! Retrying... ( #{tries} )"

				if @max_tries == -1 || tries < @max_tries
					tries += 1
					close_possibly_dead_conn(tries)
					reconnect
					retry
				else
					raise e
				end

			end

		end
		def flush
			@socket.flush unless @socket.nil
		end

		def close
			@socket.nil? ? nil : @socket.close rescue nil
		end

		def closed?
			@socket.nil? ? true : @socket.closed?
		end

		def reconnect!
			close unless closed?
			connect( @host, @port )
		end

		alias :reconnect :reconnect!

		def connect(host, port)
			if @socket.nil? || @socket.closed?
				real_connect(host, port)
			else
					@socket
			end
		end

		def real_connect(host, port)
			tries = 0
			begin
				@socket = TCPSocket.new( host, port)
				raise "Unable to create socket!" if @socket.nil?
			rescue Exception => e
				$stderr.puts "Fauled to establish connection with server! Retrying..( #{tries} )" unless @max_tries == -1
				if @max_tries == -1 || tries < @max_tries
					tries += 1
					close_possibly_dead_conn(tries)
					retry
				else
					raise e
				end
			end
		end

		def write ( msg, flush = false )
			conn_timeout do
				wrtlen = @socket.write(msg)
			end
			self.flush if flush
			@socket
		end

		def close_possibly_dead_conn( tries = 0)
			close unless @socket.nil? || closed?
			@socket = nil
			select(nil,nil,nil, tries * 0.2) if tries > 0
			@socket
		end

		def conn_timeout( &block )
			::Timeout::timeout( 6, GLO::LOG::Timeout, &block )
		end

	end
end

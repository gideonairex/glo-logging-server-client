####Install Packages 
1. npm install nasl -g
2. gem install glo-logging-server-client

####Usage:
1. First start node server using 
 * sudo nasl start
 * sudo nasl stop
2. Then access to rails
```
  log = GLO::LOG::Logger.new('appname')
  log.level = GLO::LOG::Logger::DEBUG
  log.info( 'hello world' )
```

##### Note: Check if nasl is running and cassandra
  
#### To Check for logs:
##### Access through cqlsh
```
1. use node_server
2. select * from log;
```

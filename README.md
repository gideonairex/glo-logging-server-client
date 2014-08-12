glo-logging-server-client
=========================

Install

  Node
    brew install node
  Cassandra
    brew install cassandra
  Redis
    brew install redis

Setup Cassandra keyspace
  Access through cqlsh
  1. CREATE KEYSPACE node_server WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 3 };
  # WITH is your choice except for the "node_server" keyspace it is needed in the node-async-logger-server
  2. CREATE TABLE log (
      log_id uuid,
      app text,
      log_level text,
      message text,
      tag text,
      PRIMARY KEY ((log_id))
    )
    
Install Packages 
  npm install -g node-async-logger-server
  gem install glo-logging-server-client
  

Usage:
  1. First start node server using 
    sudo nasl start
    sudo nasl stop
  2. Then access to rails
  log = GLO::LOG::Logger.new('appname')
  log.level = GLO::LOG::Logger::DEBUG
  log.info( 'hello world' )

  Note: Check if nasl is running and cassandra
  
To Check for logs:
  Access through cqlsh
    use node_server
    select * from log;
  
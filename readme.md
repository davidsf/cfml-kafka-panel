# CFML Kafka Panel

A coldbox application to create consumers groups and launch consumer to Kafka.

## License
Apache License, Version 2.0.

## Other project

You can see the kafka cfml plain example in:
- https://github.com/davidsf/cfml-kafka

## Installation

### Kafka

* Download, unzip and start Kafka.

  [Offical kafka download page](http://kafka.apache.org/downloads)

```
  cd <kafka-dir>
  sudo ./bin/zookeeper-server-start.sh -daemon config/zookeeper.properties
  sudo ./bin/kafka-server-start.sh -daemon config/server.properties
```

* Create our test topic, mytopic:
```
  sudo ./bin/kafka-topics.sh --create --topic mytopic --partitions 5 --replication-factor 1 --zookeeper localhost:2181
```
* start a console kafka client, so you can see the messages that we will send to it:
```
  ./bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic  mytopic --from-beginning
```

### Kafka Web Panel

Clone this repo and start a server with commandbox:

```
box server  start
```

In the web page you can create workerTypes, ie, consumers groups and launch consumers of that consumer group.

We have setup a worker and a workertype in the db, so you can test it without creating any code.

## How to send message to Kafka

Send a json to the topic 'mytopic' kafka. You can do it in console with the kafka-console-producer tool shipped with kafka:

```
/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic mytopic
>{ "name": "David" }
```

## How to view the processed message

So, the message is processed by the worker in models/worker1.cfc, this just write to the log if in the json message there are a name field. 

In commandbox the server logs directory is: $HOME/.CommandBox/server/$serverid/lucee-$version/WEB-INF/lucee-web/logs/. You can see a worker_consumer_myfirstgroup.log and a worker1.log (when you send the first json message with name field).
 

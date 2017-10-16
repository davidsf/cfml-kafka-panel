component accessors="true" {
  property topic;
  property groupname;
  property name;
  property consumer;
  property worker;
  property id_worker_type;

  function init() {
    variables.app = application;
    return this;
  }

  function runAndIterate(applytoRecord) {
    var logfile = "worker_consumer_#variables.groupname#.log";

    variables.consumer.subscribe([variables.topic]);
    writelog( file=logfile, text="Starting worker:  #variables.name#" );
    while(!variables.app.workers[variables.name]) {
      var records = variables.consumer.poll(1000);
      for (var record in records.iterator()) {
        try {
          applyToRecord(record);
          writelog(text="Event processed", file=logfile);
        } catch(any e) {
          writelog(text="Exception Type: #e.type# Detail: #e.detail# #e.message#", file=logfile);
          variables.app.workers[variables.name] = true;
        }
      }
      variables.consumer.commitSync();
    }
    variables.consumer.close();
    writelog( file=logfile, text="Stopping worker:  #variables.name#" );
  }
}

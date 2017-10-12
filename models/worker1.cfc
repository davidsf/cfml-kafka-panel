component extends="workerBase" {

  function run() {
    runAndIterate(function(record) {
      var event = deserializeJson(record.value());
      writelog(text="Msg recieved", file="worker1");
      if (StructKeyExists(event, "name")) {
        writelog(text="Name: " & event.name, file="worker1");
      }
    });
  }
}

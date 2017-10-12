component accessors="true" {
  property name="workerTypesService" inject="workerTypesService";
  property name="workersService" inject="workersService";
  property name="kafkaConsumerService" inject="kafkaConsumerService";
  property name="wirebox" inject="wirebox";
  property name="populator" inject="wirebox:populator";

  function launch(event, rc, prc) {
    var workerType =  variables.workerTypesService.get(rc.id);
    var thread_name = "worker_#workertype.groupname#_#createUUID()#";

    application.workers[thread_name] = false;

    thread  action="run"
            groupname=workertype.groupname
    //        kafkaConsumer = kafkaConsumer
            name=thread_name
            id_worker_type=rc.id
            topic=workerType.topic
            thread_name=thread_name
            objectname=workertype.component {
      setting requestTimeout = 2147483647;
      var init_params = {};

      var id_worker = workersService.create(id_worker_type, thread_name);
      var Kafkaconsumer = variables.KafkaConsumerService.create(topic, groupname);
      var worker = workersService.get(id_worker);
      init_params.groupname = groupname;
      init_params.name=arguments.thread_name;
      init_params.consumer = kafkaconsumer;
      init_params.topic =arguments.topic;
      init_params.worker = worker;
      init_params.id_worker_type = id_worker_type;
      //var mybean = application.beanFactory.getBean('vendido2elastic');
      var myconsumer = variables.wirebox.getInstance(objectname);
      variables.populator.populatefromStruct(myconsumer, init_params);
      myconsumer.run();
    }
    setNextEvent('main.index');
  }

  function clear(event, rc, prc) {
    workersService.clear(rc.id);
    flash.put(name='info', value='Thread remove from DB');
    setNextEvent('main.index');
  }

  /**
  * Stop a running worker
  *
  */
  function stop(event, rc, prc) {
    var worker = workersService.get(rc.id);
    application.workers[worker.thread_name] = true;
    variables.workersService.stop(rc.id);
    flash.put(name='info', value='Thread stopped');
    setNextEvent('main.index');
  }
}

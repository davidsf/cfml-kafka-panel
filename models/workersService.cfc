component {
  function getsByType(id_type) {
    return queryExecute("select * from workers where id_worker_type=:id_type",
          {id_type=arguments.id_type}) ;
  }

  function create(id_worker_type, thread_name) {
    var host = CGI.SERVER_NAME.split('\.')[1];
    var ts = DateDiff("s", CreateDate(1970,1,1), now())-(3600)
    queryExecute("insert into workers(id_worker_type, thread_name, host) values(
        :id_worker_type,
        :thread_name,
        :host
      )",
      {
        id_worker_type=arguments.id_worker_type,
        thread_name=arguments.thread_name,
        host=host
      },
      { result="myresult"}
    );
    return myresult.generatedkey;
  }

  function get(id_worker) {
    return queryExecute("select * from workers where id=:id",{id=arguments.id_worker});
  }

  function clear(id_worker) {
    queryExecute("delete from workers where id=:id", {id=arguments.id_worker});
  }

  function stop(id_worker) {
    //queryExecute("update workers set stoptime=:ts",now());
  }
}

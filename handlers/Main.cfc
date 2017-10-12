component extends="coldbox.system.EventHandler"{
  property name="workerTypesService" inject="workerTypesService";
  property name="workersService" inject="workersService";
  property name="threadService" inject="threadService";

  // Default Action
  function index(event,rc,prc){
    var workersTypes = workerTypesService.getAll();
    prc.allWorkers = [];
    for (var wt in workersTypes) {
      var myworkers = {};
      myworkers.workerType = wt;
      myworkers.workers = [];
      var workers = workersService.getsByType(wt.id);
      for (var w in workers) {
        var tmp = {};
        tmp.worker = w;
        tmp.status = variables.threadService.status(w.thread_name);
        myworkers.workers.append(tmp);
      }
      prc.allWorkers.append(myworkers);
    }
    event.setView("main/index");
  }

  // Do something
  function doSomething(event,rc,prc){
    setNextEvent("main.index");
  }
  /************************************** IMPLICIT ACTIONS *********************************************/
  function onAppInit(event,rc,prc){	}

  function onRequestStart(event,rc,prc){	}

  function onRequestEnd(event,rc,prc){	}

  function onSessionStart(event,rc,prc){	}

  function onSessionEnd(event,rc,prc){
    var sessionScope = event.getValue("sessionReference");
    var applicationScope = event.getValue("applicationReference");
  }

  function onException(event,rc,prc){
    event.setHTTPHeader( statusCode = 500
  );

  //Grab Exception From private request collection, placed by ColdBox Exception Handling
  var exception = prc.exception;

  //Place exception handler below:	}
  function onMissingTemplate(event,rc,prc){
    //Grab missingTemplate From request collection, placed by ColdBox
    var missingTemplate = event.getValue("missingTemplate");
  }
}

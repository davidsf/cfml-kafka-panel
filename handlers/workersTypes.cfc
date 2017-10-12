component extends="coldbox.system.EventHandler"{

  property name="workerTypesService" inject="workerTypesService";

  function new(event, rc, prc) {
    prc.workertype = {};
    prc.workertype.name = "";
    prc.workertype.component = "";
    prc.workertype.description = "";
    prc.workertype.topic = "";
    prc.workertype.groupname = "";
  }

  function create(event, rc, prc) {
    queryExecute("insert into workers_types(name, description, component, topic, groupname)
        values('#rc.name#', '#rc.description#', '#rc.component#', '#rc.topic#', '#rc.groupname#');
    ");
    setNextEvent('main.index');
  }

  function edit(event, rc, prc) {
    prc.workertype = queryExecute("select * from workers_types where id=#rc.id#");
  }

  function update(event, rc, prc) {
    queryExecute("
        update workers_types set
        name='#rc.name#',
        description='#rc.description#',
        topic='#rc.topic#',
        component='#rc.component#',
        groupname='#rc.groupname#'
        where id=#rc.id#");
    setNextEvent('main.index');
  }

}

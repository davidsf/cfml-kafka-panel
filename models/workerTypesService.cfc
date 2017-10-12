component singleton accessors="true" {

  function getAll() {
    return queryExecute("select * from workers_types");
  }

  function get(id) {
    return queryExecute("select * from workers_types where id=#id#");
  }
}

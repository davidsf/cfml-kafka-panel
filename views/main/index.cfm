<cfoutput>
<div class="container">

  <div class="btn-toolbar" role="toolbar">
    <a href="#event.buildLink('workersTypes.new')#" class="btn btn-default">New Type of Workers</a>
  </div>


  <table class="table">
    <thead>
      <tr>
      <th>Name</th>
      <th>Component</th>
      <th>Topic</th>
      <th>Consumer Group</th>
      <th>Actions</th>
      </tr>
    </thead>
    <tbody>
    <cfloop array="#prc.allWorkers#" index="myworker" >
      <cfset workertype = myworker.workertype>
      <cfset workers = myworker.workers>
      <tr>
        <td>#workertype.name#</td>
        <td>#workertype.component#</td>
        <td>#workertype.topic#</td>
        <td>#workertype.groupname#</td>
        <td>
          <div class="btn-toolbar">
            <a href="#event.buildlink('workerstypes.edit.id.#workerType.id#')#" class="btn btn-default">Edit</a>
            <a href="#event.buildlink('workers.launch.id.#workerType.id#')#" class="btn btn-default">Launch</a>
          </div>
        </td>
      </tr>
      <cfif not ArrayIsEmpty(workers)>
        <tr>
          <td>
          <table class="table">
            <tr>
              <th>Thread Name</th>
              <th>Status</th>
              <th>Actions</th>
            </tr>
            <cfloop array="#workers#" index="worker">
              <tr>
                <td>#worker.worker.thread_name#</td>
                <td>#worker.status#</td>
                <td>
                  <cfif worker.status=="RUNNING">
                    <a href="#event.buildLink('workers.stop.id.#worker.worker.id#')#" class="btn btn-default">Stop</a>
                  <cfelse>
                    <a href="#event.buildLink('workers.clear.id.#worker.worker.id#')#" class="btn btn-default">Clear</a>
                  </cfif>
                </td>
              </tr>
            </cfloop>
          </table>
          </td>
        </tr>
      </cfif>
    </cfloop>
  </table>
</div>
</cfoutput>

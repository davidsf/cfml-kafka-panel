<cfoutput>
  <h2>Edit worker type</h2>
<div class="container">
  <div class="row">
    <form action="#event.buildLink('workersTypes.update.id.#prc.workertype.id#')#" method="post">
      #renderview('workerstypes/_form')#
      <button type="submit" class="btn btn-primary"> Update </button>
      <a href="#event.buildLink('main.index')#"> Cancel </a>
    </form>
  </div>
</div>
</cfoutput>

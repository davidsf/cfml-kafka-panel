<cfoutput>
  <h2>New worker type</h2>
<div class="container">
  <div class="row">
    <form action="#event.buildLink('workersTypes.create')#" method="post">
      #renderview('workerstypes/_form')#
      <button type="submit" class="btn btn-primary"> Create </button>
      <a href="#event.buildLink('main.index')#"> Cancel </a>
    </form>
  </div>
</div>
</cfoutput>

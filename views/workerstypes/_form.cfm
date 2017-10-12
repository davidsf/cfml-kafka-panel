<cfoutput>
<div class="form-group">
  <label for="name">Name</label>
  <input type="text" class="form-control" required="true" name="name" value="#prc.workertype.name#">
</div>

<div class="form-group">
  <label for="description">Description</label>
  <input type="text" class="form-control" name="description" value="#prc.workertype.description#">
</div>

<div class="form-group">
  <label for="component">Component</label>
  <input type="text" class="form-control" required="true" name="component" value="#prc.workertype.component#">
</div>

<div class="form-group">
  <label for="topic">Topic</label>
  <input type="text" class="form-control" required="true" name="topic" value="#prc.workertype.topic#">
</div>

<div class="form-group">
  <label for="group">Consumer Group</label>
  <input type="text" class="form-control" required="true" name="groupname" value="#prc.workertype.groupname#">
</div>
</cfoutput>

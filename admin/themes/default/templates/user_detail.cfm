﻿<cfoutput>
<section class="content-header">
	<h1>
		User Detail
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">User Detail</li>
	</ol>
</section>

<!-- Main content -->
<form method="post">
<input type="hidden" name="id" id="id" value="#REQUEST.pageData.formData.id#" />
<section class="content">
	<div class="row">
		<div class="col-md-12">
			<cfif IsDefined("REQUEST.pageData.message") AND NOT StructIsEmpty(REQUEST.pageData.message)>
				<div class="alert #REQUEST.pageData.message.messageType# alert-dismissable">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
					<cfloop array="#REQUEST.pageData.message.messageArray#" index="msg">
					#msg#<br/>
					</cfloop>
				</div>
			</cfif>
		</div>
		<div class="col-md-12">
			<!-- general form elements -->
			<div class="box box-primary">
				<div class="box-body">
					<div class="form-group">
						<label>Last Login: #REQUEST.pageData.formData.last_login_datetime#</label>
					</div>
					<div class="form-group">
						<label>Username</label>
						<input name="username" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.username#"/>
					</div>
					<div class="form-group">
						<label>Password</label>
						<input name="password" type="text" class="form-control" placeholder="Enter ..." value=""/>
					</div>
					<div class="form-group">
						<label>Confirm Password</label>
						<input name="confirm_password" type="text" class="form-control" placeholder="Enter ..." value=""/>
					</div>
					<div class="form-group">
						<label>Name</label>
						<input name="name" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.display_name#"/>
					</div>
					<div class="form-group">
						<label>Email</label>
						<input name="email" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.email#"/>
					</div>
					<div class="form-group">
						<label>Phone</label>
						<input name="phone" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.phone#"/>
					</div>
					<button name="save_item" type="submit" class="btn btn-primary">Submit</button>
					<button type="button" class="btn btn-danger pull-right #REQUEST.pageData.deleteButtonClass#" data-toggle="modal" data-target="##delete-current-entity-modal">Delete Filter</button>
				</div><!-- /.box-body -->
			</div><!-- /.box -->
		</div><!--/.col (left) -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
<!-- DELETE ENTITY MODAL -->
<div class="modal fade" id="delete-current-entity-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this user?</h4>
			</div>
			<div class="modal-body clearfix">
				<button type="button" class="btn btn-danger pull-right" data-dismiss="modal"><i class="fa fa-times"></i> No</button>
				<button name="delete_item" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Yes</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</form>
</cfoutput>
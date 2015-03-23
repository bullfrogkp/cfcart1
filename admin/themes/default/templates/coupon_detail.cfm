﻿<cfoutput>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script>
	$(document).ready(function() {
		$('##start_date').datepicker();
		$('##end_date').datepicker();
	});
</script>
<section class="content-header">
	<h1>
		Coupon Detail
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Coupon Detail</li>
	</ol>
</section>

<!-- Main content -->
<form method="post">
<input type="hidden" name="id" value="#REQUEST.pageData.formData.id#" />
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
						<label>Code</label>
						<input type="text" name="coupon_code" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.coupon_code#"/>
					</div>
					<div class="form-group">
						<label>Discount Type</label>
						<select class="form-control" name="discount_type_id">
							<option value="">Please Select...</option>
							<cfloop array="#REQUEST.pageData.discountTypes#" index="type">
								<option value="#type.getDiscountTypeId()#"
								
								<cfif NOT IsNull(REQUEST.pageData.coupon) AND NOT IsNull(REQUEST.pageData.coupon.getDiscountType()) AND type.getDiscountTypeId() EQ REQUEST.pageData.coupon.getDiscountType().getDiscountTypeId()>
								selected
								</cfif>
								
								>#type.getDisplayName()#</option>
							</cfloop>
						</select>
					</div>
					<div class="form-group">
						<label>Status</label>
						<select class="form-control" name="coupon_status_type_id">
							<option value="">Please Select...</option>
							<cfloop array="#REQUEST.pageData.couponStatusTypes#" index="type">
								<option value="#type.getCouponStatusTypeId()#"
								
								<cfif NOT IsNull(REQUEST.pageData.coupon) AND NOT IsNull(REQUEST.pageData.coupon.getCouponStatusType()) AND type.getCouponStatusTypeId() EQ REQUEST.pageData.coupon.getCouponStatusType().getCouponStatusTypeId()>
								selected
								</cfif>
								
								>#type.getDisplayName()#</option>
							</cfloop>
						</select>
					</div>
					<div class="form-group">
						<label>Customer</label>
						<cfif NOT IsNull(REQUEST.pageData.coupon) AND NOT IsNull(REQUEST.pageData.coupon.getCustomer())>
						<a href="#APPLICATION.absoluteUrlWeb#admin/customer_detail.cfm?id=#REQUEST.pageData.coupon.getCustomer().getCustomerId()#" target="_blank">
						#REQUEST.pageData.coupon.getCustomer().getFirstName()# #REQUEST.pageData.coupon.getCustomer().getMiddleName()# #REQUEST.pageData.coupon.getCustomer().getLastName()#
						</a>
						<cfelse>
						Not assigned
						</cfif>
					</div>
					 <div class="form-group">
						<label>Start Date</label>
						<div class="input-group">
							<div class="input-group-addon">
								<i class="fa fa-calendar"></i>
							</div>
							<input type="text" class="form-control pull-right" id="start_date" name="start_date" value="#REQUEST.pageData.formData.start_date#" />
						</div><!-- /.input group -->
					</div><!-- /.form group -->
					 <div class="form-group">
						<label>End Date</label>
						<div class="input-group">
							<div class="input-group-addon">
								<i class="fa fa-calendar"></i>
							</div>
							<input type="text" class="form-control pull-right" id="end_date" name="end_date" value="#REQUEST.pageData.formData.end_date#"/>
						</div><!-- /.input group -->
					</div><!-- /.form group -->
					<button type="submit" name="save_item" class="btn btn-primary">Submit</button>
				</div><!-- /.box-body -->
			</div><!-- /.box -->
		</div><!--/.col (left) -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
</form>
</cfoutput>
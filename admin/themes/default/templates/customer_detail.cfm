﻿<cfoutput>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script>
	$(document).ready(function() {
		$('##reservation').datepicker();
		
		$(".tab-title").click(function() {
		  $("##tab_id").val($(this).attr('tabid'));
		});
		
		$( ".delete-address" ).click(function() {
			$("##address_id").val($(this).attr('addressid'));
		});
	});
</script>
<section class="content-header">
	<h1>
		Customer Detail
		<small>customer information</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Customer Detail</li>
	</ol>
</section>

<!-- Main content -->
<form method="post">
<input type="hidden" name="id" id="id" value="#REQUEST.pageData.customer.getCustomerId()#" />
<input type="hidden" name="tab_id" id="tab_id" value="#REQUEST.pageData.tabs.activeTabId#" />
<input type="hidden" name="address_id" id="address_id" value="" />
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
			<!-- Custom Tabs -->
			<div class="nav-tabs-custom">
				<ul class="nav nav-tabs">
					<li class="tab-title #REQUEST.pageData.tabs['tab_1']#" tabid="tab_1"><a href="##tab_1" data-toggle="tab">Activities</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_2']#" tabid="tab_2"><a href="##tab_2" data-toggle="tab">Account Information</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_3']#" tabid="tab_3"><a href="##tab_3" data-toggle="tab">Orders</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_4']#" tabid="tab_4"><a href="##tab_4" data-toggle="tab">Addresses</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_5']#" tabid="tab_5"><a href="##tab_5" data-toggle="tab">Reviews</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_6']#" tabid="tab_6"><a href="##tab_6" data-toggle="tab">Change Password</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane #REQUEST.pageData.tabs['tab_1']#" id="tab_1">
					
						<dl class="dl-horizontal">
							<dt>Last Logged In Dateime:</dt>
							<dd><span class="info-section">#TimeFormat(REQUEST.pageData.customer.getLastLoginDatetime(),"hh:mm:ss")# #DateFormat(REQUEST.pageData.customer.getLastLoginDatetime(),"mmm dd, yyyy")#</span></dd>
							<dt>Last Logged In IP:</dt>
							<dd><span class="info-section">#REQUEST.pageData.customer.getLastLoginIP()#</span></dd>
							<dt>Created Dateime:</dt>
							<dd><span class="info-section">#REQUEST.pageData.customer.getCreatedDatetime()#</span></dd>
							<dt>Created IP:</dt>
							<dd><span class="info-section">#REQUEST.pageData.customer.getCreatedUser()#</span></dd>
						</dl>
						
						<div class="form-group">
							<label>Shopping Cart</label>
							<table class="table table-bordered table-striped">
								<thead>
									<tr>
										<th>Product</th>
										<th>Description</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
									<cfif NOT IsNull(REQUEST.pageData.customer.getShoppingCartProducts()) AND ArrayLen(REQUEST.pageData.customer.getShoppingCartProducts()) NEQ 0>
										<cfloop array="#REQUEST.pageData.customer.getShoppingCartProducts()#" index="product">
										<tr>
											<td>#product.getDisplayName()#</td>
											<td>#product.getDescription()#</td>
											<td><a href="#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?id=#product.getProductId()#">View Detail</a></td>
										</tr>
										</cfloop>
									<cfelse>
										<tr>
											<td colspan="3">No result found</td>
										</tr>
									</cfif>
								</tbody>
							</table>
						</div>
						<div class="form-group">
							<label>Buy Later</label>
							<table class="table table-bordered table-striped">
								<thead>
									<tr>
										<th>Product</th>
										<th>Description</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
									<cfif NOT IsNull(REQUEST.pageData.customer.getBuyLaterProducts()) AND ArrayLen(REQUEST.pageData.customer.getBuyLaterProducts()) NEQ 0>
										<cfloop array="#REQUEST.pageData.customer.getBuyLaterProducts()#" index="product">
											<tr>
												<td>#product.getDisplayName()#</td>
												<td>#product.getDescription()#</td>
												<td><a href="#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?id=#product.getProductId()#">View Detail</a></td>
											</tr>
										</cfloop>
									<cfelse>
										<tr>
											<td colspan="3">No result found</td>
										</tr>
									</cfif>
								</tbody>
							</table>
						</div>
						
						<div class="form-group">
							<label>Wishlist</label>
							<table class="table table-bordered table-striped">
								<thead>
									<tr>
										<th>Product</th>
										<th>Description</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
									<cfif NOT IsNull(REQUEST.pageData.customer.getWishListProducts()) AND ArrayLen(REQUEST.pageData.customer.getWishListProducts()) NEQ 0>
										<cfloop array="#REQUEST.pageData.customer.getWishListProducts()#" index="product">
											<tr>
												<td>#product.getDisplayName()#</td>
												<td>#product.getDescription()#</td>
												<td><a href="#APPLICATION.absoluteUrlWeb#admin/product_detail.cfm?id=#product.getProductId()#">View Detail</a></td>
											</tr>
										</cfloop>
									<cfelse>
										<tr>
											<td colspan="3">No result found</td>
										</tr>
									</cfif>
								</tbody>
							</table>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_2']#" id="tab_2">
					
						<div class="form-group">
							<label>Prefix</label>
							<input type="text" name="prefix" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.prefix#"/>
						</div>
						 <div class="form-group">
							<label>First Name</label>
							<input type="text" name="first_name" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.first_name#"/>
						</div>
						<div class="form-group">
							<label>Middle Name</label>
							<input type="text" name="middle_name" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.middle_name#"/>
						</div>
						<div class="form-group">
							<label>Last Name</label>
							<input type="text" name="last_name" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.last_name#"/>
						</div>
						<div class="form-group">
							<label>Suffix</label>
							<input type="text" name="suffix" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.suffix#"/>
						</div>
						 <div class="form-group">
							<label>Date of Birth</label>
							<div class="input-group">
								<div class="input-group-addon">
									<i class="fa fa-calendar"></i>
								</div>
								<input type="text" name="date_of_birth" class="form-control pull-right" id="reservation" value="#REQUEST.pageData.formData.date_of_birth#"/>
							</div><!-- /.input group -->
						</div><!-- /.form group -->
						<div class="form-group">
							<label>Gender</label>
							<select class="form-control" name="gender">
								<option value="">Please Select...</option>
								<option value="Male" <cfif REQUEST.pageData.formData.gender EQ "Male">selected</cfif>>Male</option>
								<option value="Female" <cfif REQUEST.pageData.formData.gender EQ "Female">selected</cfif>>Female</option>
							</select>
						</div>
						 <div class="form-group">
							<label>Email</label>
							<input type="text" name="email" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.email#"/>
						</div>
						<div class="form-group">
							<label>Website</label>
							<input type="text" name="website" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.website#"/>
						</div>
						 <div class="form-group">
							<label>Customer Group</label>
							<select class="form-control" name="customer_group_id">
								<option value="">Please Select...</option>
								<cfloop array="#REQUEST.pageData.customerGroups#" index="group">
								<option value="#group.getCustomerGroupId()#"
								
								<cfif group.getCustomerGroupId() EQ REQUEST.pageData.customer.getCustomerGroup().getCustomerGroupId()>
								selected
								</cfif>
								
								>#group.getDisplayName()#</option>
								</cfloop>
							</select>
						</div>
						 <div class="form-group">
							<label>Subscribed</label>
							<select class="form-control" name="subscribed">
								<option value="1" <cfif REQUEST.pageData.formData.subscribed EQ 1>selected</cfif>>Yes</option>
								<option value="0" <cfif REQUEST.pageData.formData.subscribed NEQ 1>selected</cfif>>No</option>
							</select>
						</div>
						 <div class="form-group">
							<label>Status</label>
							<select class="form-control" name="is_enabled">
								<option value="1" <cfif REQUEST.pageData.formData.is_enabled EQ 1>selected</cfif>>Enabled</option>
								<option value="0" <cfif REQUEST.pageData.formData.is_enabled EQ 0>selected</cfif>>Disabled</option>
							</select>
						</div>
						<div class="form-group">
							<label>Comments</label>
							<textarea name="description" class="form-control" rows="5" placeholder="Enter ...">#REQUEST.pageData.formData.description#</textarea>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_3']#" id="tab_3">
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>Order No.</th>
									<th>Purchase On</th>
									<th>Bill To</th>
									<th>Ship To</th>
									<th>Total</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<cfif NOT IsNull(REQUEST.pageData.customer.getOrders()) AND ArrayLen(REQUEST.pageData.customer.getOrders()) NEQ 0>
									<cfloop array="#REQUEST.pageData.customer.getOrders()#" index="order">
										<tr>
											<td>#order.getOrderTrackingNumber()#</td>
											<td>#order.getCreatedDatetime()#</td>
											<td>#order.getBillingFirstName()# #order.getBillingMiddleName()# #order.getBillingLastName()#</td>
											<td>#order.getShippingFirstName()# #order.getShippingMiddleName()# #order.getShippingLastName()#</td>
											<td>#order.getTotal()#</td>
											<td><a href="#APPLICATION.absoluteUrlWeb#admin/order_detail.cfm?id=#order.getOrderId()#">View Detail</a></td>
										</tr>
									</cfloop>
								<cfelse>
									<tr>
										<td colspan="6">No result found</td>
									</tr>
								</cfif>
							</tbody>
							<tfoot>
								<tr>
									<th>Order No.</th>
									<th>Purchase On</th>
									<th>Bill To</th>
									<th>Ship To</th>
									<th>Total</th>
									<th>Action</th>
								</tr>
							</tfoot>
						</table>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_4']#" id="tab_4">
						<div class="form-group">
							<label>Address(es)</label>
							<a href="" data-toggle="modal" data-target="##add-address-modal" style="margin-left:10px;"><span class="label label-primary">Add Address</span></a>
							<div class="row" style="margin-top:10px;">
								<cfif NOT IsNull(REQUEST.pageData.customer.getAddresses())>
								<cfloop array="#REQUEST.pageData.customer.getAddresses()#" index="address">								
									<div class="col-xs-3">
										<div class="box box-warning">
											<div class="box-body table-responsive no-padding">
												<table class="table table-hover">
													<tr>
														<th>ID: #address.getAddressId()#</th>
														<th>
															<a addressid="#address.getAddressId()#" href="" class="delete-address pull-right" data-toggle="modal" data-target="##delete-address-modal"><span class="label label-danger">Delete</span></a>
														</th>
													</tr>
													<tr>
														<td>Street</td>
														<td>#address.getStreet()#</td>
													</tr>
													<tr>
														<td>Unit</td>
														<td>#address.getUnit()#</td>
													</tr>
													<tr>
														<td>City</td>
														<td>#address.getCity()#</td>
													</tr>
													<tr>
														<td>Province</td>
														<td>#address.getProvince().getDisplayName()#</td>
													</tr>
													<tr>
														<td>Postal Code</td>
														<td>#address.getPostalCode()#</td>
													</tr>
													<tr>
														<td>Country</td>
														<td>#address.getCountry().getDisplayName()#</td>
													</tr>
												</table>
											</div><!-- /.box-body -->
										</div><!-- /.box -->
									</div>
								</cfloop>
								</cfif>
							</div>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_5']#" id="tab_5">
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>Subject</th>
									<th>Message</th>
									<th>Rating</th>
									<th>Create Datetime</th>
									<th>Create User</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<cfif NOT IsNull(REQUEST.pageData.customer.getReviews()) AND ArrayLen(REQUEST.pageData.customer.getReviews()) NEQ 0>
									<cfloop array="#REQUEST.pageData.customer.getReviews()#" index="review">
										<tr>
											<td>#review.getSubject()#</td>
											<td>#review.getMessage()#</td>
											<td>#review.getRating()#</td>
											<td>#review.getCreatedDatetime()#</td>
											<td>#review.getCreatedUser()#</td>
											<td><a href="#APPLICATION.absoluteUrlWeb#admin/review_detail.cfm?id=#review.getReviewId()#">View Detail</a></td>
										</tr>
									</cfloop>
								<cfelse>
									<tr>
										<td colspan="6">No result found</td>
									</tr>
								</cfif>
							</tbody>
							<tfoot>
								<tr>
									<th>Subject</th>
									<th>Message</th>
									<th>Rating</th>
									<th>Create Datetime</th>
									<th>Create User</th>
									<th>Action</th>
								</tr>
							</tfoot>
						</table>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_6']#" id="tab_6">
						 <div class="form-group">
							<label>Current Password</label>
							<input type="password" class="form-control" placeholder="Enter ..." value=""/>
						</div>
						 <div class="form-group">
							<label>New Password</label>
							<input type="password" class="form-control" placeholder="Enter ..." value=""/>
						</div>
						  <div class="form-group">
							<label>Confirm New Password</label>
							<input type="password" class="form-control" placeholder="Enter ..." value=""/>
						</div>
					</div>
				</div><!-- /.tab-content -->
			</div><!-- nav-tabs-custom -->
			<div class="form-group">
				<button name="save_item" type="submit" class="btn btn-primary top-nav-button">Save Customer</button>
				<button name="add_order" type="submit" class="btn btn-primary top-nav-button">Add Order</button>
				<button name="delete_item" type="submit" class="btn btn-danger pull-right top-nav-button #REQUEST.pageData.deleteButtonClass#">Delete Customer</button>
			</div>
		</div><!-- /.col -->
		
	</div>   <!-- /.row -->
</section><!-- /.content -->
<!-- ADD ADDRESS MODAL -->
<div class="modal fade" id="add-address-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Add New Address</h4>
			</div>
		
			<div class="modal-body">
				<div class="form-group">
					<input id="new_address_street" name="new_address_street" type="text" class="form-control" placeholder="Street">
				</div>
				<div class="form-group">
					<input id="new_address_unit" name="new_address_unit" type="text" class="form-control" placeholder="Unit">
				</div>
				<div class="form-group">
					<input id="new_address_city" name="new_address_city" type="text" class="form-control" placeholder="City">
				</div>
				<div class="form-group">
					<select class="form-control" name="new_address_province_id">
						<option value="">Please Select Province...</option>
						<cfloop array="#REQUEST.pageData.provinces#" index="province">
							<option value="#province.getProvinceId()#">#province.getDisplayName()#</option>
						</cfloop>
					</select>
				</div>
				<div class="form-group">
					<input id="new_address_postal_code" name="new_address_postal_code" type="text" class="form-control" placeholder="Postal Code">
				</div>
				<div class="form-group">
					<select class="form-control" name="new_address_country_id">
						<option value="">Please Select Country...</option>
						<cfloop array="#REQUEST.pageData.countries#" index="country">
							<option value="#country.getCountryId()#">#country.getDisplayName()#</option>
						</cfloop>
					</select>
				</div>
			</div>
			<div class="modal-footer clearfix">
				<button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Cancel</button>
				<button name="add_new_address" type="submit" class="btn btn-primary pull-left"><i class="fa fa-check"></i> Add</button>
			</div>
		
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- DELETE ADDRESS MODAL -->
<div class="modal fade" id="delete-address-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this address?</h4>
			</div>
			<div class="modal-body clearfix">
				<button type="button" class="btn btn-danger pull-right" data-dismiss="modal"><i class="fa fa-times"></i> No</button>
				<button name="delete_address" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Yes</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</form>
</cfoutput>
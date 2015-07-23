﻿<cfcomponent extends="master">
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset SESSION.temp.message = {} />
		<cfset SESSION.temp.message.messageArray = [] />
		<cfset SESSION.temp.message.messageType = "alert-success" />
		
		<cfif IsNumeric(FORM.id)>
			<cfset LOCAL.productGroup = EntityLoadByPK("product_group", FORM.id)> 
			<cfset LOCAL.productGroup.setUpdatedUser(SESSION.adminUser) />
			<cfset LOCAL.productGroup.setUpdatedDatetime(Now()) />
		<cfelse>
			<cfset LOCAL.productGroup = EntityNew("product_group") />
			<cfset LOCAL.productGroup.setIsDeleted(false) />
		</cfif>
		
		<cfif StructKeyExists(FORM,"save_item")>
		
			<cfset LOCAL.productGroup.setDisplayName(Trim(FORM.display_name)) />
			<cfset LOCAL.productGroup.removeAllProducts() />
			
			<cfif StructKeyExists(FORM,"products_selected") AND FORM.products_selected NEQ "">
				<cfloop list="#FORM.products_selected#" index="LOCAL.productId">
					<cfset LOCAL.productGroup.addProduct(EntityLoadByPK("product",LOCAL.productId)) />
				</cfloop>
			</cfif>
			
			<cfset EntitySave(LOCAL.productGroup) />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.productGroup.getProductGroupId()#" />
			
		<cfelseif StructKeyExists(FORM,"delete_item")>
			
			<cfset LOCAL.productGroup.setIsDeleted(true) />
			
			<cfset EntitySave(LOCAL.productGroup) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Product group has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/product_groups.cfm" />
			
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.categoryService = new "#APPLICATION.componentPathRoot#core.services.categoryService"() />
		<cfset LOCAL.pageData.categoryTree = LOCAL.categoryService.getCategoryTree() />
		<cfset LOCAL.pageData.productGroups = EntityLoad("product_group") />
		
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.pageData.productGroup = EntityLoadByPK("product_group", URL.id)> 
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.productGroup.getDisplayName()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />	
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.display_name = LOCAL.pageData.productGroup.getDisplayName() />
				<cfset LOCAL.pageData.formData.id = URL.id />
			</cfif>
		<cfelse>
			<cfset LOCAL.pageData.title = "Product Group | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "hide-this" />
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.display_name = "" />
				<cfset LOCAL.pageData.formData.id = "" />
			</cfif>
		</cfif>
		
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>
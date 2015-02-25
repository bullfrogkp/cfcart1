﻿<cfcomponent output="false" accessors="true">
    <cfproperty name="productId" type="numeric"> 
    <cfproperty name="attributeSetId" type="numeric"> 
    <cfproperty name="productTypeId" type="numeric"> 
    <cfproperty name="categoryId" type="numeric"> 
    <cfproperty name="name" type="string"> 
    <cfproperty name="searchKeywords" type="string"> 
    <cfproperty name="displayName" type="string"> 
    <cfproperty name="isEnabled" type="boolean"> 
    <cfproperty name="isDeleted" type="boolean"> 
    <cfproperty name="offset" type="numeric"> 
    <cfproperty name="limit" type="numeric"> 

    <cffunction name="getProducts" output="false" access="public" returntype="array">
		<cfset LOCAL = {} />
	   
	    <cfif getSearchKeywords() NEQ "">
			<cfset LOCAL.qry = "from products p where (p.display_name like '%#getSearchKeywords()#%' or p.keywords like '%#getSearchKeywords()#%' or p.description like '%#getSearchKeywords()#%' )" > 
			
			<cfif NOT IsNull(getProductId())>
				<cfset LOCAL.qry = LOCAL.qry & "and p.product_id = '#getProductId()#' " />
			</cfif>
			<cfif NOT IsNull(getProductTypeId())>
				<cfset LOCAL.qry = LOCAL.qry & "and p.product_type_id = '#getProductTypeId()#' " />
			</cfif>
			<cfif NOT IsNull(getCategoryId())>
				<cfset LOCAL.qry = LOCAL.qry & "and exists(from category_product_rela cpr where cpr.category_id = '#getCategoryId()#' and cpr.product_id = p.product_id) " />
			</cfif>
			<cfif NOT IsNull(getIsEnabled())>
				<cfset LOCAL.qry = LOCAL.qry & "and p.is_enabled = '#getIsEnabled()#' " />
			</cfif>
			
			<cfset LOCAL.products = ORMExecuteQuery(LOCAL.qry)> 
		<cfelse>
			<cfset LOCAL.filter = {} />
			<cfif NOT IsNull(getProductId())>
				<cfset LOCAL.filter.productId = getProductId() />
			</cfif>
			<cfif NOT IsNull(getProductTypeId())>
				<cfset LOCAL.filter.productTypeId = getProductTypeId() />
			</cfif>
			<cfif NOT IsNull(getIsEnabled())>
				<cfset LOCAL.filter.isEnabled = getIsEnabled() />
			</cfif>
			
			<cfset LOCAL.products = EntityLoad('product',LOCAL.filter)> 
		</cfif>
	   
		<cfreturn LOCAL.products />
    </cffunction>
		
	<cffunction name="getProductGroupPrices" output="false" access="public" returntype="array">
		<cfset var LOCAL = {} />
			   
	    <cfquery name="LOCAL.getProductGroupPrices">
			SELECT	pcgr.price, cg.customer_group_id
			FROM	product_customer_group_rela pcgr
			JOIN	customer_group cg ON cg.customer_group_id = pcgr.customer_group_id
			WHERE	pcgr.product_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#getProductId()#" />
			ORDER BY pcgr.price
		</cfquery>
		
		<cfset LOCAL.priceArray = [] />
		
		<cfoutput query="LOCAL.getProductGroupPrices" group="price">
			<cfset LOCAL.priceStruct = {} />
			<cfset LOCAL.priceStruct.price = LOCAL.getProductGroupPrices.price />
			<cfset LOCAL.priceStruct.customerGroupIdList = "" />
			<cfoutput>
				<cfset LOCAL.priceStruct.customerGroupIdList = LOCAL.priceStruct.customerGroupIdList & LOCAL.getProductGroupPrices.customer_group_id & "," />
			</cfoutput>
			<cfset ArrayAppend(LOCAL.priceArray, LOCAL.priceStruct) />
		</cfoutput>
 
		<cfreturn LOCAL.priceArray />
    </cffunction>
	
	<cffunction name="getProductAttributes" output="false" access="public" returntype="array">
		<cfset LOCAL = {} />
	   
		<cfquery name="LOCAL.getAttributes">
			SELECT	attr.attribute_id
			,		attr.display_name
			,		asar.required
			FROM	attribute attr
			JOIN	attribute_set_attribute_rela asar ON asar.attribute_id = attr.attribute_id
			WHERE	asar.attribute_set_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#getAttributeSetId()#" /> 
		</cfquery>
		
		<cfset LOCAL.attributeArray = [] />
		<cfloop query="LOCAL.getAttributes">
			<cfset LOCAL.attributeStruct = {} />
			<cfset LOCAL.attributeStruct.name = LOCAL.getAttributes.display_name />
			<cfset LOCAL.attributeStruct.required = LOCAL.getAttributes.required />
			<cfset LOCAL.attributeStruct.attributeId = LOCAL.getAttributes.attribute_id />
			
			<cfset LOCAL.attributeStruct.attributeValueArray = [] />
			
			 <cfquery name="LOCAL.getAttributeValues">
				SELECT	av.attribute_value_id, av.value, av.min_value, av.max_value,av.image_name
				FROM	attribute_value av
				WHERE	av.product_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#getProductId()#" />
				AND		av.attribute_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#LOCAL.getAttributes.attribute_id#" />
			</cfquery>
			
			<cfloop query="LOCAL.getAttributeValues">
				<cfset LOCAL.attributeValueStruct = {} />
				<cfset LOCAL.attributeValueStruct.attributeValueId = LOCAL.getAttributeValues.attribute_value_id />
				<cfset LOCAL.attributeValueStruct.imageName = LOCAL.getAttributeValues.image_name />
				<cfset LOCAL.attributeValueStruct.value = LOCAL.getAttributeValues.value />
				<cfset LOCAL.attributeValueStruct.minValue = LOCAL.getAttributeValues.min_value />
				<cfset LOCAL.attributeValueStruct.maxValue = LOCAL.getAttributeValues.max_value />
				<cfset ArrayAppend(LOCAL.attributeStruct.attributeValueArray, LOCAL.attributeValueStruct) />
			</cfloop>
			
			<cfset ArrayAppend(LOCAL.attributeArray, LOCAL.attributeStruct) />
		</cfloop>
 
		<cfreturn LOCAL.attributeArray />
    </cffunction>
	
	<cffunction name="isProductAttributeComplete" output="false" access="public" returntype="boolean">
		<cfset LOCAL = {} />
	   
		<cfquery name="LOCAL.getAttributes">
			SELECT	attr.attribute_id
			FROM	attribute attr
			JOIN	attribute_set_attribute_rela asar ON asar.attribute_id = attr.attribute_id
			WHERE	asar.attribute_set_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#getAttributeSetId()#" /> 
			AND		asar.required = true
		</cfquery>
		
		<cfquery name="LOCAL.getAttributeValues">
			SELECT	DISTINCT attribute_id
			FROM	attribute_value
			WHERE	product_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#getProductId()#" />
		</cfquery>
		
		<cfif LOCAL.getAttributes.recordCount EQ LOCAL.getAttributeValues.recordCount>
			<cfset LOCAL.retValue = true />
		<cfelse>
			<cfset LOCAL.retValue = false />
		</cfif>
 
		<cfreturn LOCAL.retValue />
    </cffunction>
</cfcomponent>
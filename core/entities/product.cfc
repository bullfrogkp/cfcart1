﻿<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="productId" column="product_id" fieldtype="id" generator="native">
	<cfproperty name="sku" column="sku" ormtype="string"> 
	<cfproperty name="title" column="title" ormtype="string"> 
	<cfproperty name="keywords" column="keywords" ormtype="string"> 
	<cfproperty name="stock" column="stock" ormtype="integer"> 
	<cfproperty name="detail" column="detail" ormtype="text"> 
	
	<cfproperty name="length" column="length" ormtype="float"> 
	<cfproperty name="width" column="width" ormtype="float"> 
	<cfproperty name="height" column="height" ormtype="float"> 
	<cfproperty name="weight" column="weight" ormtype="float"> 
	
	<cfproperty name="attributeSet" fieldtype="many-to-one" cfc="attribute_set" fkcolumn="attribute_set_id">
	<cfproperty name="taxCategory" fieldtype="many-to-one" cfc="tax_category" fkcolumn="tax_category_id">
	
	<cfproperty name="productAttributeRelas" type="array" fieldtype="one-to-many" cfc="product_attribute_rela" fkcolumn="product_id" singularname="productAttributeRela" cascade="delete-orphan">
	<cfproperty name="productVideos" type="array" fieldtype="one-to-many" cfc="product_video" fkcolumn="product_id" singularname="productVideo" cascade="delete-orphan">
	
	<cfproperty name="parentProduct" fieldtype="many-to-one" cfc="product" fkcolumn="parent_product_id">
	<cfproperty name="subProducts" type="array" fieldtype="one-to-many" cfc="product" fkcolumn="parent_product_id" singularname="subProduct" cascade="delete-orphan">
	
	<cfproperty name="reviews" type="array" fieldtype="one-to-many" cfc="review" fkcolumn="product_id" singularname="review" cascade="delete-orphan">
	<cfproperty name="images" type="array" fieldtype="one-to-many" cfc="product_image" fkcolumn="product_id" singularname="image" cascade="delete-orphan" orderby="rank">
	<cfproperty name="productCustomerGroupRelas" type="array" fieldtype="one-to-many" cfc="product_customer_group_rela" fkcolumn="product_id" singularname="productCustomerGroupRela" cascade="delete-orphan">
	<cfproperty name="productShippingMethodRelas" type="array" fieldtype="one-to-many" cfc="product_shipping_method_rela" fkcolumn="product_id" singularname="productShippingMethodRela" cascade="delete-orphan">
	
	<cfproperty name="categories" fieldtype="many-to-many" cfc="category" linktable="category_product_rela" fkcolumn="product_id" inversejoincolumn="category_id" singularname="category">
	<cfproperty name="relatedProducts" fieldtype="many-to-many" cfc="product" linktable="related_product_rela" fkcolumn="product_id" inversejoincolumn="related_parent_product_id" singularname="relatedProduct">
	<cfproperty name="relatedParentProducts" fieldtype="many-to-many" cfc="product" linktable="related_product_rela" fkcolumn="related_parent_product_id" inversejoincolumn="product_id" singularname="relatedParentProduct">
	
	<cfproperty name="searchKeyword" type="string" persistent="false"> 
	<!------------------------------------------------------------------------------->	
	<cffunction name="getTitle" access="public" output="false" returnType="string">
		<cfset var retValue = "" />
		
		<cfif NOT IsNull(getParentProduct())>
			<cfset retValue = getParentProduct().getTitle() />
		<cfelse>
			<cfset retValue = getTitle() />
		</cfif>
		
		<cfreturn retValue />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getKeywords" access="public" output="false" returnType="string">
		<cfset var retValue = "" />
		
		<cfif NOT IsNull(getParentProduct())>
			<cfset retValue = getParentProduct().getKeywords() />
		<cfelse>
			<cfset retValue = getKeywords() />
		</cfif>
		
		<cfreturn retValue />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getDetail" access="public" output="false" returnType="string">
		<cfset var retValue = "" />
		
		<cfif NOT IsNull(getParentProduct())>
			<cfset retValue = getParentProduct().getDetail() />
		<cfelse>
			<cfset retValue = getDetail() />
		</cfif>
		
		<cfreturn retValue />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getLength" access="public" output="false" returnType="string">
		<cfset var retValue = "" />
		
		<cfif NOT IsNull(getParentProduct())>
			<cfset retValue = getParentProduct().getLength() />
		<cfelse>
			<cfset retValue = getLength() />
		</cfif>
		
		<cfreturn retValue />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getWidth" access="public" output="false" returnType="string">
		<cfset var retValue = "" />
		
		<cfif NOT IsNull(getParentProduct())>
			<cfset retValue = getParentProduct().getWidth() />
		<cfelse>
			<cfset retValue = getWidth() />
		</cfif>
		
		<cfreturn retValue />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getHeight" access="public" output="false" returnType="string">
		<cfset var retValue = "" />
		
		<cfif NOT IsNull(getParentProduct())>
			<cfset retValue = getParentProduct().getHeight() />
		<cfelse>
			<cfset retValue = getHeight() />
		</cfif>
		
		<cfreturn retValue />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getWeight" access="public" output="false" returnType="string">
		<cfset var retValue = "" />
		
		<cfif NOT IsNull(getParentProduct())>
			<cfset retValue = getParentProduct().getWeight() />
		<cfelse>
			<cfset retValue = getWeight() />
		</cfif>
		
		<cfreturn retValue />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getAttributeSet" access="public" output="false" returnType="any">
		<cfset var retValue = "" />
		
		<cfif NOT IsNull(getParentProduct())>
			<cfset retValue = getParentProduct().getAttributeSet() />
		<cfelse>
			<cfset retValue = getAttributeSet() />
		</cfif>
		
		<cfreturn retValue />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getTaxCategory" access="public" output="false" returnType="any">
		<cfset var retValue = "" />
		
		<cfif NOT IsNull(getParentProduct())>
			<cfset retValue = getParentProduct().getTaxCategory() />
		<cfelse>
			<cfset retValue = getTaxCategory() />
		</cfif>
		
		<cfreturn retValue />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getProductVideos" access="public" output="false" returnType="array">
		<cfset var retValue = "" />
		
		<cfif NOT IsNull(getParentProduct())>
			<cfset retValue = getParentProduct().getProductVideos() />
		<cfelse>
			<cfset retValue = getProductVideos() />
		</cfif>
		
		<cfreturn retValue />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getReviews" access="public" output="false" returnType="array">
		<cfset var retValue = "" />
		
		<cfif NOT IsNull(getParentProduct())>
			<cfset retValue = getParentProduct().getReviews() />
		<cfelse>
			<cfset retValue = getReviews() />
		</cfif>
		
		<cfreturn retValue />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getImages" access="public" output="false" returnType="array">
		<cfset var retValue = "" />
		
		<cfif NOT IsNull(getParentProduct())>
			<cfset retValue = getParentProduct().getImages() />
		<cfelse>
			<cfset retValue = getImages() />
		</cfif>
		
		<cfreturn retValue />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getProductShippingMethodRelas" access="public" output="false" returnType="array">
		<cfset var retValue = "" />
		
		<cfif NOT IsNull(getParentProduct())>
			<cfset retValue = getParentProduct().getProductShippingMethodRelas() />
		<cfelse>
			<cfset retValue = getProductShippingMethodRelas() />
		</cfif>
		
		<cfreturn retValue />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getCategories" access="public" output="false" returnType="array">
		<cfset var retValue = "" />
		
		<cfif NOT IsNull(getParentProduct())>
			<cfset retValue = getParentProduct().getCategories() />
		<cfelse>
			<cfset retValue = getCategories() />
		</cfif>
		
		<cfreturn retValue />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getRelatedProducts" access="public" output="false" returnType="array">
		<cfset var retValue = "" />
		
		<cfif NOT IsNull(getParentProduct())>
			<cfset retValue = getParentProduct().getRelatedProducts() />
		<cfelse>
			<cfset retValue = getRelatedProducts() />
		</cfif>
		
		<cfreturn retValue />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getRelatedParentProducts" access="public" output="false" returnType="array">
		<cfset var retValue = "" />
		
		<cfif NOT IsNull(getParentProduct())>
			<cfset retValue = getParentProduct().getRelatedParentProducts() />
		<cfelse>
			<cfset retValue = getRelatedParentProducts() />
		</cfif>
		
		<cfreturn retValue />
	</cffunction>
	
	<!------------------------------------------------------------------------------->	
	<cffunction name="removeAllCategories" access="public" output="false" returnType="void">
		<cfif NOT IsNull(getCategories())>
			<cfset ArrayClear(getCategories()) />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="removeSubProducts" access="public" output="false" returnType="void">
		<cfif NOT IsNull(getSubProducts())>
			<cfset ArrayClear(getSubProducts()) />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="removeProductAttributeRelas" access="public" output="false" returnType="void">
		<cfif NOT IsNull(getProductAttributeRelas())>
			<cfset ArrayClear(getProductAttributeRelas()) />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="removeProductShippingMethodRelas" access="public" output="false" returnType="void">
		<cfif NOT IsNull(getProductShippingMethodRelas())>
			<cfset ArrayClear(getProductShippingMethodRelas()) />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getPrice" access="public" output="false" returnType="string">
		<cfargument name="customerGroupName" type="string" required="true">
		
		<cfset var customerGroup = EntityLoad("customer_group",{name = ARGUMENTS.customerGroupName},true) />
		<cfset var product = EntityLoadByPK("product",getProductId()) />
		<cfset var productCustomeGroupRela = EntityLoad("product_customer_group_rela",{customerGroup=customerGroup,product=product},true) />
		<cfset var price = 0 />
		
		<cfif NOT IsNull(productCustomeGroupRela)>
			<cfif IsNumeric(productCustomeGroupRela.getSpecialPrice())>
				<cfif IsDate(productCustomeGroupRela.getSpecialPriceFromDate()) AND IsDate(productCustomeGroupRela.getSpecialPriceToDate())>
					<cfif 	DateCompare(productCustomeGroupRela.getSpecialPriceFromDate(), DateFormat(Now())) LTE 0
							AND
							DateCompare(DateFormat(Now()), productCustomeGroupRela.getSpecialPriceToDate()) LTE 0>
						<cfset price = productCustomeGroupRela.getSpecialPrice() />
					<cfelse>
						<cfset price = productCustomeGroupRela.getPrice() />
					</cfif>
				<cfelseif IsDate(productCustomeGroupRela.getSpecialPriceFromDate())>
					<cfif DateCompare(productCustomeGroupRela.getSpecialPriceFromDate(), DateFormat(Now())) LTE 0>
						<cfset price = productCustomeGroupRela.getSpecialPrice() />
					<cfelse>
						<cfset price = productCustomeGroupRela.getPrice() />
					</cfif>
				<cfelseif IsDate(productCustomeGroupRela.getSpecialPriceToDate())>
					<cfif 	DateCompare(DateFormat(Now()), productCustomeGroupRela.getSpecialPriceToDate()) LTE 0>
						<cfset price = productCustomeGroupRela.getSpecialPrice() />
					<cfelse>
						<cfset price = productCustomeGroupRela.getPrice() />
					</cfif>
				<cfelse>
					<cfset price = productCustomeGroupRela.getPrice() />
				</cfif>
			<cfelse>
				<cfset price = productCustomeGroupRela.getPrice() />
			</cfif>
		</cfif>
		
		<cfreturn NumberFormat(price,"0.00") />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getDefaultImageLink" access="public" output="false" returnType="string">
		<cfargument name="type" type="string" required="false" default="" />
		
		<cfif NOT IsNull(getParentProduct())>
			<cfset imageLink = getParentProduct().getDefaultImageLink() />
		<cfelse>
			<cfset var imageType = "" />
			<cfif Trim(ARGUMENTS.type) NEQ "">
				<cfset imageType = "#Trim(ARGUMENTS.type)#_" />
			</cfif>
			
			<cfset var imageLink = "" />
			<cfset var productImg = EntityLoad("product_image",{product = this, isDefault = true},true) />
			
			<cfif IsNull(productImg)>
				<cfif NOT IsNull(getImages()) AND ArrayLen(getImages()) GT 0>
					<cfset imageLink = "#APPLICATION.absoluteUrlWeb#images/uploads/product/#getProductId()#/#imageType##getImages()[1].getName()#" />
				<cfelse>
					<cfset imageLink = "#APPLICATION.absoluteUrlWeb#images/site/no_image_available.png" />
				</cfif>
			<cfelse>
				<cfset imageLink = "#APPLICATION.absoluteUrlWeb#images/uploads/product/#getProductId()#/#imageType##productImg.getName()#" />
			</cfif>
		</cfif>
		
		<cfreturn imageLink />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="isFreeShipping" access="public" output="false" returnType="boolean">
		<cfset var LOCAL = {} />
		<cfset var retValue = false />
		
		<cfif NOT IsNull(getParentProduct())>
			<cfset retValue = getParentProduct().isFreeShipping() />
		<cfelse>
			<cfquery name="LOCAL.checkFreeShipping">
				SELECT	1
				FROM	product_shipping_method_rela psmr
				JOIN	shipping_method sm ON psmr.shipping_method_id = sm.shipping_method_id
				WHERE	sm.name = 'chinapost'
				AND		psmr.product_id = #getProductId()#
			</cfquery>
			
			<cfif LOCAL.checkFreeShipping.recordCount GT 0>
				<cfset retValue = true />
			</cfif>
		</cfif>
		
		<cfreturn retValue />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getDetailPageURL" access="public" output="false" returnType="string">
		<cfset var pageUrl = "" />
		<cfif NOT IsNull(getParentProduct())>
			<cfset pageUrl = getParentProduct().getDetailPageURL() />
		<cfelse>
			<cfset pageUrl = "#APPLICATION.absoluteUrlWeb#product_detail.cfm/#URLEncodedFormat(getDisplayName())#/#getProductId()#" />
		</cfif>
		<cfreturn pageUrl />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getTaxRate" access="public" output="false" returnType="string">
		<cfargument name="provinceId" type="numeric" required="true" />
				
		<cfset var tax = EntityLoad("tax",{province=EntityLoadByPK("province",ARGUMENTS.provinceId), taxCategory=getTaxCategory()},true) />
		
		<cfreturn tax.getRate() />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getShippingFee" access="public" output="false" returnType="numeric">
		<cfargument name="address" type="struct" required="true" />
		<cfargument name="shippingMethodId" type="numeric" required="true" />
		<cfargument name="customerGroupName" type="string" required="true" />
		
		<cfset var LOCAL = {} />
		
		<cfif NOT IsNull(getParentProduct())>
			<cfset LOCAL.shippingFee = getParentProduct().getShippingFee(argumentCollection = ARGUMENTS) />
		<cfelse>
			<cfif NOT IsNull(getWeight())>
				<cfset LOCAL.shippingMethod = EntityLoadByPK("shipping_method",ARGUMENTS.shippingMethodId) />
				<cfset LOCAL.componentName = LOCAL.shippingMethod.getShippingCarrier().getComponent() />
			
				<cfset LOCAL.shippingComponent = new "#APPLICATION.componentPathRoot#core.shipping.#LOCAL.componentName#"() />
							
				<cfset LOCAL.shippingComponent.setShippingMethodId(ARGUMENTS.shippingMethodId) />
				<cfset LOCAL.shippingComponent.setAddress(ARGUMENTS.address) />
				<cfset LOCAL.shippingComponent.setProductId(LOCAL.productId) />
				
				<cfset LOCAL.shippingFee = LOCAL.shippingComponent.getShippingFee() />
			<cfelse>
				<cfset LOCAL.shippingFee = getPrice(customerGroupName = ARGUMENTS.customerGroupName) />
			</cfif>
		</cfif>
		
		<cfreturn NumberFormat(LOCAL.shippingFee,"0.00") />
	</cffunction>
	<!------------------------------------------------------------------------------->	
</cfcomponent>

﻿<cfcomponent extends="master">	
	<!---
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif StructKeyExists(FORM,"update_cutomer_info")>
			<cfif NOT IsValid("email",Trim(FORM.new_email))>
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid email address.") />
			</cfif>
			
			<cfif Trim(FORM.shipto_first_name) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid shipping first name.") />
			</cfif>
			<cfif Trim(FORM.shipto_last_name) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid shipping last name.") />
			</cfif>
			<cfif Trim(FORM.shipto_phone) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid shipping phone number.") />
			</cfif>
			<cfif Trim(FORM.shipto_street) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid shipping street name.") />
			</cfif>
			<cfif Trim(FORM.shipto_city) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid shipping city name.") />
			</cfif>
			<cfif NOT IsNumeric(FORM.shipto_province_id)>
				<cfset ArrayAppend(LOCAL.messageArray,"Please choose your shipping province.") />
			</cfif>
			<cfif Trim(FORM.shipto_postal_code) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid shipping postal code.") />
			</cfif>
			<cfif NOT IsNumeric(FORM.shipto_country_id)>
				<cfset ArrayAppend(LOCAL.messageArray,"Please choose your shipping country.") />
			</cfif>
			
			<cfif StructKeyExists(FORM,"billing_info_is_different")>
				<cfif Trim(FORM.billto_first_name) EQ "">
					<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid billing first name.") />
				</cfif>
				<cfif Trim(FORM.billto_last_name) EQ "">
					<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid billing last name.") />
				</cfif>
				<cfif Trim(FORM.billto_phone) EQ "">
					<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid billing phone number.") />
				</cfif>
				<cfif Trim(FORM.billto_street) EQ "">
					<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid billing street name.") />
				</cfif>
				<cfif Trim(FORM.billto_city) EQ "">
					<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid billing city name.") />
				</cfif>
				<cfif NOT IsNumeric(FORM.billto_province_id)>
					<cfset ArrayAppend(LOCAL.messageArray,"Please choose your billing province.") />
				</cfif>
				<cfif Trim(FORM.billto_postal_code) EQ "">
					<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid billing postal code.") />
				</cfif>
				<cfif NOT IsNumeric(FORM.billto_country_id)>
					<cfset ArrayAppend(LOCAL.messageArray,"Please choose your billing country.") />
				</cfif>
			</cfif>
		</cfif>
		
		<cfif ArrayLen(LOCAL.messageArray) GT 0>
			<cfset SESSION.temp.message = {} />
			<cfset SESSION.temp.message.messageArray = LOCAL.messageArray />
			<cfset LOCAL.redirectUrl = CGI.SCRIPT_NAME />
		</cfif>
		
		<cfreturn LOCAL />
	</cffunction>
	--->
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Customer Information | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		
		<cfset LOCAL.pageData.provinces = EntityLoad("province") />
		<cfset LOCAL.pageData.countries = EntityLoad("country") />
		
		<cfif IsDefined("SESSION.temp.message") AND NOT ArrayIsEmpty(SESSION.temp.message.messageArray)>
			<cfset LOCAL.pageData.message.messageArray = SESSION.temp.message.messageArray />
		</cfif>
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		
		<cfset SESSION.cart.setIsExistingCustomer(false) />
		<cfset SESSION.cart.setSameAddress(true) />
		
		<cfset LOCAL.customer = {} />
		<cfset LOCAL.customer.customerId = "" />
		<cfset LOCAL.customer.email = Trim(FORM.new_email) />
		<cfset LOCAL.customer.phone = Trim(FORM.shipto_phone) />
		<cfset LOCAL.customer.firstName = Trim(FORM.shipto_first_name) />
		<cfset LOCAL.customer.middleName = Trim(FORM.shipto_middle_name) />
		<cfset LOCAL.customer.lastName = Trim(FORM.shipto_last_name) />
		<cfif LOCAL.customer.middleName EQ "">
			<cfset LOCAL.customer.fullName = LOCAL.customer.firstName & " " & LOCAL.customer.lastName />
		<cfelse>
			<cfset LOCAL.customer.fullName = LOCAL.customer.firstName & " " & LOCAL.customer.middleName & " " & LOCAL.customer.lastName />
		</cfif>
		<cfset LOCAL.customer.company = Trim(FORM.shipto_company) />
		<cfset SESSION.cart.setCustomer(LOCAL.customer) />
			
		<cfset LOCAL.shippingAddress = {} />
		<cfset LOCAL.shippingAddress.useExistingAddress = false />
		<cfset LOCAL.shippingAddress.addressId = "" />
		<cfset LOCAL.shippingAddress.company = Trim(FORM.shipto_company) />
		<cfset LOCAL.shippingAddress.firstName = Trim(FORM.shipto_first_name) />
		<cfset LOCAL.shippingAddress.middleName = Trim(FORM.shipto_middle_name) />
		<cfset LOCAL.shippingAddress.lastName = Trim(FORM.shipto_last_name) />
		<cfset LOCAL.shippingAddress.phone = Trim(FORM.shipto_phone) />
		<cfset LOCAL.shippingAddress.unit = Trim(FORM.shipto_unit) />
		<cfset LOCAL.shippingAddress.street = Trim(FORM.shipto_street) />
		<cfset LOCAL.shippingAddress.city = Trim(FORM.shipto_city) />
		<cfset LOCAL.shippingAddress.postalCode = Trim(FORM.shipto_postal_code) />
		
		<cfset LOCAL.province = EntityLoadByPK("province",FORM.shipto_province_id) />
		<cfset LOCAL.shippingAddress.provinceId = FORM.shipto_province_id />
		<cfset LOCAL.shippingAddress.provinceCode = LOCAL.province.getCode() />
		
		<cfset LOCAL.country = EntityLoadByPK("country",FORM.shipto_country_id) />
		<cfset LOCAL.shippingAddress.countryId = FORM.shipto_country_id />
		<cfset LOCAL.shippingAddress.countryCode = LOCAL.country.getCode() />
		
		<cfset SESSION.cart.setShippingAddress(LOCAL.shippingAddress) />
		
		<cfset LOCAL.billingAddress = Duplicate(LOCAL.shippingAddress) />
		
		<cfset SESSION.cart.setBillingAddress(LOCAL.billingAddress) />
		
		<cfset LOCAL.totalTax = 0 />
		<cfloop array="#SESSION.cart.getProductArray()#" index="LOCAL.item">
			<cfset LOCAL.product = EntityLoadByPK("product",LOCAL.item.productId) />
			<cfset LOCAL.item.singleTax = NumberFormat(LOCAL.item.singlePrice * LOCAL.product.getTaxRateMV(provinceId = LOCAL.shippingAddress.provinceId),"0.00") />
			<cfset LOCAL.item.totalTax = LOCAL.item.singleTax * LOCAL.item.count />
			<cfset LOCAL.totalTax += LOCAL.item.totalTax />
		</cfloop>
		<cfset SESSION.cart.setTotalTax(LOCAL.totalTax) />
		
		<cfset SESSION.cart.setTotalPrice(SESSION.cart.getSubTotalPrice() + LOCAL.totalTax) />
		
		<cfloop array="#SESSION.order.productArray#" index="LOCAL.item">
			<cfset LOCAL.product = EntityLoadByPK("product",LOCAL.item.productId) />
			<cfset LOCAL.productShippingMethodRelas = LOCAL.product.getProductShippingMethodRelasMV() />
			
			<cfset LOCAL.item.shippingMethodArray = [] />
		
			<cfloop array="#LOCAL.productShippingMethodRelas#" index="LOCAL.productShippingMethodRela">
				<cfset LOCAL.shippingMethod = LOCAL.productShippingMethodRela.getShippingMethod() />
				<cfset LOCAL.shippingMethodStruct = {} />
				<cfset LOCAL.shippingMethodStruct.productShippingMethodRelaId = LOCAL.productShippingMethodRela.getProductShippingMethodRelaId() />
				<cfset LOCAL.shippingMethodStruct.name = LOCAL.shippingMethod.getDisplayName() />
				<cfset LOCAL.shippingMethodStruct.logo = LOCAL.shippingMethod.getShippingCarrier().getImageName() />
				<cfset LOCAL.shippingMethodStruct.price = LOCAL.product.getShippingFeeMV(	address = SESSION.order.shippingAddress
																						, 	shippingMethodId = LOCAL.shippingMethod.getShippingMethodId()
																						,	customerGroupName = SESSION.user.customerGroupName) * LOCAL.item.count />
				
				<cfset LOCAL.shippingMethodStruct.label = "#LOCAL.shippingMethod.getShippingCarrier().getDisplayName()# - #LOCAL.shippingMethod.getDisplayName()#" />
			
				<cfset ArrayAppend(LOCAL.item.shippingMethodArray, LOCAL.shippingMethodStruct) />
			</cfloop>
		</cfloop>
		
		<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#checkout/checkout_step2.cfm" />
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>
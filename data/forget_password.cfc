﻿<cfcomponent extends="master">	
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif StructKeyExists(FORM,"send_email")>
			<cfif NOT IsValid("email",Trim(FORM.email))>
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid email.") />
			<cfelse>
				<cfset LOCAL.customer = EntityLoad("customer",{email=Trim(FORM.email)},true) />
				<cfif IsNull(LOCAL.customer)>
					<cfset ArrayAppend(LOCAL.messageArray,"Sorry we cannot find the customer with the email: #Trim(FORM.email)#.") />
				</cfif>
			</cfif>
		</cfif>
		
		<cfif ArrayLen(LOCAL.messageArray) GT 0>
			<cfset SESSION.temp.message = {} />
			<cfset SESSION.temp.message.messageArray = LOCAL.messageArray />
			<cfset SESSION.temp.message.messageType = "alert-danger" />
			<cfset LOCAL.redirectUrl = CGI.SCRIPT_NAME />
		</cfif>
		
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Password Assistance | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		
		<cfif StructKeyExists(FORM,"send_email")>
			<cfset LOCAL.customer = EntityLoad("customer",{email=Trim(FORM.email)},true) />
			
			<cfset LOCAL.emailService = new "#APPLICATION.componentPathRoot#core.services.email"() />
			<cfset LOCAL.emailService.setFromEmail(APPLICATION.emailCustomerService) />
			<cfset LOCAL.emailService.setToEmail(Trim(FORM.email)) />
			<cfset LOCAL.emailService.setContentName("reset password") />
			
			<cfset LOCAL.replaceStruct = {} />
			<cfset LOCAL.replaceStruct.customerName = LOCAL.customer.getFirstname() />
			
			<cfset LOCAL.emailService.setReplaceStruct(LOCAL.replaceStruct) />
			<cfset LOCAL.emailService.sendEmail() />
		
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#email_sent.cfm" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>
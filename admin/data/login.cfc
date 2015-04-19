﻿<cfcomponent extends="master">
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif Trim(FORM.username) EQ "">
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid username.") />
		</cfif>
		<cfif Trim(FORM.password) EQ "">
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter your password.") />
		</cfif>
		
		<cfif Trim(FORM.username) NEQ "" AND Trim(FORM.password) NEQ "">
			<cfset LOCAL.userService = new "#APPLICATION.componentPathRoot#core.services.userService"() />
			<cfset LOCAL.userService.setUsername(Trim(FORM.username)) />
			<cfset LOCAL.userService.setPassword(Trim(FORM.password)) />
			<cfif LOCAL.userService.isUserValid() EQ false>
				<cfset ArrayAppend(LOCAL.messageArray,"Username or password is not correct.") />
			</cfif>
		</cfif>
		
		<cfif ArrayLen(LOCAL.messageArray) GT 0>
			<cfset SESSION.temp.message = {} />
			<cfset SESSION.temp.message.messageArray = LOCAL.messageArray />
			<cfset SESSION.temp.message.messageType = "alert-danger" />
			<cfset LOCAL.redirectUrl = _setRedirectURL() />
		</cfif>
		
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		
		<cfset LOCAL.user = EntityLoad("user",{username=Trim(FORM.username)},true) />
		<cfset LOCAL.user.setLastLoginDatetime(Now()) />
		<cfset SESSION.adminUser = LOCAL.user.getUsername() />
		<cfset LOCAL.redirectUrl = "index.cfm" />
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.message = _setTempMessage() />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>
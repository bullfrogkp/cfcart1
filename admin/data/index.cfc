﻿<cfcomponent extends="master">
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Dashboard | #APPLICATION.applicationName#" />
		
		<cfset LOCAL.pageData.newOrders = EntityLoad() />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>
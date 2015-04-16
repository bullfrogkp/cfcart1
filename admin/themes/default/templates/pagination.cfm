﻿<cfoutput>
	<cfif REQUEST.pageData.paginationInfo.totalPages GT 1>
	<ul class="pagination pagination-sm no-margin pull-right">
		<cfif REQUEST.pageData.paginationInfo.currentPage NEQ 1>
			<li><a href="#APPLICATION.absoluteUrlWeb#admin/#REQUEST.pageData.currentPageName#.cfm?#REQUEST.pageData.paginationInfo.currentQueryString#page=1">&laquo;</a></li>
		</cfif>
		<cfloop from="1" to="#REQUEST.pageData.paginationInfo.totalPages#" index="i">
			<li <cfif REQUEST.pageData.paginationInfo.currentPage EQ i>class="active"</cfif>><a href="#APPLICATION.absoluteUrlWeb#admin/#REQUEST.pageData.currentPageName#.cfm?#REQUEST.pageData.paginationInfo.currentQueryString#page=#i#">#i#</a></li>
		</cfloop>
		<cfif REQUEST.pageData.paginationInfo.currentPage NEQ REQUEST.pageData.paginationInfo.totalPages>
			<li><a href="#APPLICATION.absoluteUrlWeb#admin/#REQUEST.pageData.currentPageName#.cfm?#REQUEST.pageData.paginationInfo.currentQueryString#page=#REQUEST.pageData.paginationInfo.totalPages#">&raquo;</a></li>
		</cfif>
	</ul>
	</cfif>
</cfoutput>
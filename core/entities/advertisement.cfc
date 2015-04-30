﻿<cfcomponent persistent="true"> 
    <cfproperty name="advertisementId" column="advertisement_id" fieldtype="id" generator="native"> 
	<cfproperty name="name" column="name" ormtype="string"> 
    <cfproperty name="rank" column="rank" ormtype="float"> 
	<cfproperty name="section" fieldtype="many-to-one" cfc="section" fkcolumn="section_id">
</cfcomponent>
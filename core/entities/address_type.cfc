﻿<cfcomponent persistent="true"> 
    <cfproperty name="addressTypeId" column="address_type_id" fieldtype="id" generator="native"> 
    <cfproperty name="displayName" column="display_name" ormtype="string"> 
</cfcomponent>
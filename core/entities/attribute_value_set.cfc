﻿<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="attributeValueSetId" column="attribute_value_set_id" fieldtype="id" generator="native">
	<cfproperty name="attributeValues" type="array" fieldtype="one-to-many" cfc="attribute_value" fkcolumn="attributeValueSetId">
</cfcomponent>
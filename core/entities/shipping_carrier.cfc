﻿<cfcomponent persistent="true"> 
    <cfproperty name="shippingCarrierId" column="shipping_carrier_id" fieldtype="id" generator="native"> 
	<cfproperty name="imageName" column="image_name" ormtype="string"> 
	<cfproperty name="component" column="component" ormtype="string"> 
	<cfproperty name="shippingMethods" type="array" fieldtype="one-to-many" cfc="shipping_method" fkcolumn="shipping_carrier_id" singularname="shippingMethod" cascade="delete-orphan">
</cfcomponent>

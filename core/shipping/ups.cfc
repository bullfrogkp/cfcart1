<cfcomponent extends="service" output="false" accessors="true">
	<cfproperty name="shippingMethodId" type="numeric"> 
    <cfproperty name="address" type="struct"> 
	<!------------------------------------------------------------------------------->
	<cffunction name="getShippingAmount" access="public" returntype="numeric">
		<cfargument name="shipping_method_id" type="numeric" required="true">
	    <cfargument name="items_array" type="array" required="true">
	    <cfargument name="address_struct" type="struct" required="false">
		
		<cfset var LOCAL = StructNew() />
		
		<cfinvoke component="#APPLICATION.db_cfc_path#db.shipping_methods" method="getShippingMethods" returnvariable="LOCAL.shipping_method_detail">
			<cfinvokeargument name="shipping_method_id" value="#ARGUMENTS.shipping_method_id#">
		</cfinvoke>
						
		<cfset LOCAL.xmlData = createShippingRateXml(	items_array = ARGUMENTS.items_array
													,	ship_from_address = APPLICATION.ship_from_address
													,	ship_to_address = ARGUMENTS.address_struct
													,	service_code = LOCAL.shipping_method_detail.service_code)>										
										
		
		<cfset LOCAL.shippingRate = submitXml(xml_data = LOCAL.xmlData, xml_data_type = "rate")>			
	
		<cfreturn LOCAL.shippingRate["RatingServiceSelectionResponse"]["RatedShipment"]["TotalCharges"]["MonetaryValue"].xmlText>
		
	</cffunction>	
	<!------------------------------------------------------------------------------->	
	<cffunction name="createShippingRateXml" displayname="Create XML Documents" description="Creates the XML needed to send to UPS" access="private" output="false" returntype="Any">
		<cfargument name="items_array" type="Array" required="true">
		<cfargument name="ship_from_address" type="struct" required="true">
		<cfargument name="ship_to_address" type="struct" required="true">
		<cfargument name="service_code" type="string" required="true">
		
		<cfset var LOCAL = {} />
		<cfset LOCAL.total_weight = 0 />
		
		<cfxml variable="LOCAL.xmlShippingRequest" casesensitive="true">
			<cfoutput>
			<RatingServiceSelectionRequest>
				<Request>
					<RequestAction>Rate</RequestAction>
				</Request>
				<PickupType>
					<Code>06</Code>
				</PickupType>
				<Shipment>
					<Shipper>
						<Address>
							<AddressLine1>#ARGUMENTS.ship_from_address.street#</AddressLine1>
							<City>#ARGUMENTS.ship_from_address.city#</City>
							<StateProvinceCode>#ARGUMENTS.ship_from_address.province_code#</StateProvinceCode>
							<PostalCode>#ARGUMENTS.ship_from_address.postal_code#</PostalCode>
							<CountryCode>#ARGUMENTS.ship_from_address.country_code#</CountryCode>
						</Address>
					</Shipper>
					<ShipTo>
						<Address>
							<AddressLine1>#ARGUMENTS.ship_to_address.street#</AddressLine1>
							<City>#ARGUMENTS.ship_to_address.city#</City>
							<StateProvinceCode>#ARGUMENTS.ship_to_address.province_code#</StateProvinceCode>
							<PostalCode>#ARGUMENTS.ship_to_address.postal_code#</PostalCode>
							<CountryCode>#ARGUMENTS.ship_to_address.country_code#</CountryCode>
						</Address>
					</ShipTo>
					<Service>
						<Code>#ARGUMENTS.service_code#</Code>
					</Service>
					
					<cfloop from="1" to="#ArrayLen(ARGUMENTS.items_array)#" index="i">						
						<cfset LOCAL.total_weight += items_array[i].quantity * items_array[i].weight />
					</cfloop>	
													
					<Package>
						<PackagingType>
							<Code>02</Code>
							<Description>Package</Description>
						</PackagingType>
						<Description>Rate Shopping</Description>
						<PackageWeight>
							<UnitOfMeasurement>
								<Code>LBS</Code>
							</UnitOfMeasurement>
							<Weight>#xmlFormat(LOCAL.total_weight)#</Weight>
						</PackageWeight>
					</Package>
					
					<ShipmentServiceOptions/>
				</Shipment>
			</RatingServiceSelectionRequest>
			</cfoutput>
		</cfxml>

		<cfsavecontent variable="LOCAL.xmlShippingData">
			<?xml version="1.0"?>
			<AccessRequest xml:lang="en-US">
				<cfoutput>
					<AccessLicenseNumber>#xmlFormat(APPLICATION.ups.accesskey)#</AccessLicenseNumber>
					<UserId>#xmlFormat(APPLICATION.ups.upsuserid)#</UserId>
					<Password>#xmlFormat(APPLICATION.ups.upspassword)#</Password>
				</cfoutput>
			</AccessRequest>
			<cfoutput>#LOCAL.xmlShippingRequest#</cfoutput>
		</cfsavecontent>	
		<cfreturn LOCAL.xmlShippingData>
	</cffunction>

	<!------------------------------------------------------------------------------->
	
	<!------------------------------------------------------------------------------->
	<cffunction name="createTrackingXml" displayname="Create XML Documents" description="Creates the XML needed to send to UPS" access="private" output="false" returntype="Any">
		<cfargument name="track_number" type="string" required="true">
		
		<cfxml variable="LOCAL.xmlTrackingRequest" casesensitive="true">
			<cfoutput>
			<TrackRequest>
				<Request>
					<RequestAction>Track</RequestAction>
				</Request>
				<TrackingNumber>#ARGUMENTS.track_number#</TrackingNumber>
			</TrackRequest>
			</cfoutput>
		</cfxml>

		<cfsavecontent variable="LOCAL.xmlShippingData">
			<?xml version="1.0"?>
			<AccessRequest xml:lang="en-US">
				<cfoutput>
					<AccessLicenseNumber>#xmlFormat(APPLICATION.ups.accesskey)#</AccessLicenseNumber>
					<UserId>#xmlFormat(APPLICATION.ups.upsuserid)#</UserId>
					<Password>#xmlFormat(APPLICATION.ups.upspassword)#</Password>
				</cfoutput>
			</AccessRequest>
			<cfoutput>#LOCAL.xmlTrackingRequest#</cfoutput>
		</cfsavecontent>	
		<cfreturn LOCAL.xmlShippingData>
	</cffunction>

	<!------------------------------------------------------------------------------->
	
	<!------------------------------------------------------------------------------->
	<cffunction name="createAddressValidationXml" displayname="Create XML Documents" description="Creates the XML needed to send to UPS" access="private" output="false" returntype="Any">
		<cfargument name="ship_to_address" type="struct" required="true">
		
		<cfxml variable="LOCAL.xmlShippingRequest" casesensitive="true">
			<cfoutput>
			<AddressValidationRequest xml:lang="en-US">
				<Request>
					<TransactionReference>
						<CustomerContext>Address Varification</CustomerContext>
						<XpciVersion>1.0</XpciVersion>
					</TransactionReference>
					<RequestAction>AV</RequestAction>
				</Request>
				<Address>
					<City>#ARGUMENTS.ship_to_address.shipto_city#</City>
					<StateProvinceCode>#ARGUMENTS.ship_to_address.shipto_province_code#</StateProvinceCode>
					<CountryCode>#ARGUMENTS.ship_to_address.shipto_country_code#</CountryCode>
					<PostalCode>#ARGUMENTS.ship_to_address.shipto_postal_code#</PostalCode>
				</Address>
			</AddressValidationRequest>
			</cfoutput>
		</cfxml>

		<cfsavecontent variable="LOCAL.xmlShippingData">
			<?xml version="1.0"?>
			<AccessRequest xml:lang="en-US">
				<cfoutput>
					<AccessLicenseNumber>#xmlFormat(APPLICATION.ups.accesskey)#</AccessLicenseNumber>
					<UserId>#xmlFormat(APPLICATION.ups.upsuserid)#</UserId>
					<Password>#xmlFormat(APPLICATION.ups.upspassword)#</Password>
				</cfoutput>
			</AccessRequest>
			<cfoutput>#LOCAL.xmlShippingRequest#</cfoutput>
		</cfsavecontent>	
		<cfreturn LOCAL.xmlShippingData>
	</cffunction>

	<!------------------------------------------------------------------------------->
	
	<cffunction name="submitXml" displayname="Submit XML" description="Submits XML documents to UPS to get the response data" access="private" output="false" returntype="any">
		<cfargument name="xml_data_type" type="string" required="true">
		<cfargument name="xml_data" type="string" required="true">
		
		<cfif xml_data_type EQ "rate">
			<cfset LOCAL.submit_url = APPLICATION.ups.rate_url />
		<cfelseif xml_data_type EQ "av">
			<cfset LOCAL.submit_url = APPLICATION.ups.av_url />
		<cfelseif xml_data_type EQ "tracking">
			<cfset LOCAL.submit_url = APPLICATION.ups.tracking_url />
		</cfif>
		
		<cfhttp url="#LOCAL.submit_url#" method="post" result="LOCAL.shippingData">
			<cfhttpparam type="xml" value="#ARGUMENTS.xml_data#">
		</cfhttp>
		
		<cfset LOCAL.xmlDataParsed = xmlparse(LOCAL.shippingData.filecontent)>
		
		<cfreturn LOCAL.xmlDataParsed>
	</cffunction>
	<!------------------------------------------------------------------------------->
	
	<!------------------------------------------------------------------------------->
	<cffunction name="validateAddressUPS" access="public" returntype="boolean">
	    <cfargument name="address_struct" type="struct" required="false">
		
		<cfset var LOCAL = StructNew() />
		
		<cfset LOCAL.items_array = ArrayNew(1) />
		<cfset LOCAL.item = StructNew() />
		
		<cfquery name="LOCAL.getItemId" datasource="#APPLICATION.data_source#">
			SELECT 	TOP(1) item_id
			FROM	items;
		</cfquery>
		
		<cfset LOCAL.item.item_id = LOCAL.getItemId.item_id />
		<cfset LOCAL.item.quantity = 1 />
		<cfset LOCAL.item.weight = 1 />
		<cfset ArrayAppend(LOCAL.items_array,LOCAL.item) />
		
		<cfinvoke component="#APPLICATION.db_cfc_path#db.provinces" method="getProvinces" returnvariable="province_detail">
			<cfinvokeargument name="province_id" value="#ARGUMENTS.address_struct.province_id#">
		</cfinvoke>
		
		<cfset ARGUMENTS.address_struct.province_code = province_detail.province_code />
					
		<cfinvoke component="#APPLICATION.db_cfc_path#db.countries" method="getCountries" returnvariable="country_detail">
			<cfinvokeargument name="country_id" value="#ARGUMENTS.address_struct.country_id#">
		</cfinvoke>			
		
		<cfset ARGUMENTS.address_struct.country_code = country_detail.country_code />	
		
		<cfset LOCAL.xmlData = createShippingRateXml(	items_array = LOCAL.items_array
													,	ship_from_address = APPLICATION.ship_from_address
													,	ship_to_address = ARGUMENTS.address_struct
													,	service_code = 11)>	
													
		<cfset LOCAL.shippingRate = submitXml(xml_data = LOCAL.xmlData, xml_data_type = "rate")>									
		<cfif XmlSearch(LOCAL.shippingRate, "/RatingServiceSelectionResponse/Response/ResponseStatusDescription")[1].xmlText EQ "success">
			<cfreturn TRUE />
		<cfelse>
			<cfreturn FALSE />
		</cfif>							
		
	</cffunction>	
	<!------------------------------------------------------------------------------->	
	
	<!------------------------------------------------------------------------------->
	<cffunction name="trackUPSPackage" access="public" returntype="struct">
	    <cfargument name="track_number" type="string" required="false">
		
		<cfset var LOCAL = StructNew() />
		<cfset var ret_struct = StructNew() />
		
		<cfset LOCAL.xmlData = createTrackingXml(track_number = ARGUMENTS.track_number)>
		<cfset LOCAL.tracking_response = submitXml(xml_data = LOCAL.xmlData, xml_data_type = "tracking")>	
		
		<cfif XmlSearch(LOCAL.tracking_response, "/TrackResponse/Response/ResponseStatusDescription")[1].xmlText EQ "success">
			<cfset ret_struct.activity = StructNew() />
			<cfset ret_struct.activity.city = XmlSearch(LOCAL.tracking_response, "/TrackResponse/Shipment/Package/Activity/ActivityLocation/Address/City")[1].xmlText />
			<cfset ret_struct.activity.state_province_code = XmlSearch(LOCAL.tracking_response, "/TrackResponse/Shipment/Package/Activity/ActivityLocation/Address/StateProvinceCode")[1].xmlText />
			<cfset ret_struct.activity.country_code = XmlSearch(LOCAL.tracking_response, "/TrackResponse/Shipment/Package/Activity/ActivityLocation/Address/CountryCode")[1].xmlText />
			<cfset ret_struct.activity.date = XmlSearch(LOCAL.tracking_response, "/TrackResponse/Shipment/Package/Activity/Date")[1].xmlText />
			<cfset ret_struct.activity.time = XmlSearch(LOCAL.tracking_response, "/TrackResponse/Shipment/Package/Activity/Time")[1].xmlText />
			<cfset ret_struct.activity.status_description = XmlSearch(LOCAL.tracking_response, "/TrackResponse/Shipment/Package/Activity/Status/StatusType/Description")[1].xmlText />
		</cfif>
		
		<cfreturn ret_struct />
	</cffunction>	
	<!------------------------------------------------------------------------------->	
</cfcomponent>
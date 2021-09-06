component {

	property name="extremeIpLookupServiceWrapper" inject="extremeIpLookupServiceWrapper";
	property name="ipwhoisIpLookupServiceWrapper" inject="ipwhoisIpLookupServiceWrapper";
	property name="systemConfigurationService"    inject="systemConfigurationService";

	// Backwards compatability
	public any function testAjaxGetIp( event, prc, rc, args={} ) {
		return ajaxGetIp( argumentCollection = arguments );
	}
	public struct function testGetIp( event, prc, rc, args={} ) {
		return getIp( argumentCollection = arguments );
	}

	// Core public methods
	public any function ajaxGetIp( event, prc, rc, args={} ) {
		var visitorIpAddress = rc.ipAddress ?: "";

		if( !len( trim( visitorIpAddress ) ) ){ event.notFound(); }
		if( event.isStatelessRequest() ){ return extremeIpLookupServiceWrapper.scaffoldBlankResponse() };

		if( IsIPv6( visitorIpAddress ) ){
			var format = systemConfigurationService.getSetting( "ip_geolocation", "ipv6_result_format", "json" );
			var result = ipwhoisIpLookupServiceWrapper.getIp( ipAddress = visitorIpAddress );
		} else {
			var format = systemConfigurationService.getSetting( "ip_geolocation", "result_format", "json" );
			var result = extremeIpLookupServiceWrapper.getIp( ipAddress = visitorIpAddress );
		}

		if( isStruct( result ) ) {
			event.renderData( type=format, data=result );
		} else {
			event.renderData( type=format, data={ error=true, message=result } );
		}
	}

	public struct function getIp( event, prc, rc, args={} ) {
		var visitorIpAddress = rc.ipAddress ?: "";

		if( !len( trim( visitorIpAddress ) ) ){ event.notFound(); }
		if( event.isStatelessRequest() ){ return extremeIpLookupServiceWrapper.scaffoldBlankResponse() };

		if( IsIPv6( visitorIpAddress ) ){
			var result = ipwhoisIpLookupServiceWrapper.getIp( ipAddress = visitorIpAddress );
		} else {
			var result = extremeIpLookupServiceWrapper.getIp( ipAddress = visitorIpAddress );
		}

		if( isStruct( result ) ) {
			return result;
		} else {
			return { error=true, message=result };
		}
	}

	public any function proxyGetIp( event, prc, rc, args={} ) {
		var visitorIpAddress = rc.ipAddress ?: "";

		if( !len( trim( visitorIpAddress ) ) ){ event.notFound(); }
		if( event.isStatelessRequest() ){ return extremeIpLookupServiceWrapper.scaffoldBlankResponse() };

		if( IsIPv6( visitorIpAddress ) ){
			var result = ipwhoisIpLookupServiceWrapper.getIp( ipAddress = visitorIpAddress );
		} else {
			var result = extremeIpLookupServiceWrapper.getIp( ipAddress = visitorIpAddress );
		}

		dump( visitorIpAddress );
		dump( result )
		abort;
	}

}
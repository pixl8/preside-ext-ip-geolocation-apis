component {

	property name="extremeIpLookupServiceWrapper" inject="extremeIpLookupServiceWrapper";
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
		if( !len( rc.ipAddress ?: "" ) ){ event.notFound(); }
		if( event.isStatelessRequest() ){ return extremeIpLookupServiceWrapper.scaffoldBlankResponse() };

		var format = systemConfigurationService.getSetting( "ip_geolocation", "result_format", "json" );
		var result = extremeIpLookupServiceWrapper.getIp( ipAddress = rc.ipAddress );

		if( isStruct( result ) ) {
			event.renderData( type=format, data=result );
		} else {
			event.renderData( type=format, data={ error=true, message=result } );
		}
	}

	public struct function getIp( event, prc, rc, args={} ) {
		if( !len( rc.ipAddress ?: "" ) ){ event.notFound(); }
		if( event.isStatelessRequest() ){ return extremeIpLookupServiceWrapper.scaffoldBlankResponse() };

		var result = extremeIpLookupServiceWrapper.getIp( ipAddress = rc.ipAddress );

		if( isStruct( result ) ) {
			return result;
		} else {
			return { error=true, message=result };
		}
	}

	public any function proxyGetIp( event, prc, rc, args={} ) {
		if( !len( rc.ipAddress ?: "" ) ){ event.notFound(); }
		if( event.isStatelessRequest() ){ return extremeIpLookupServiceWrapper.scaffoldBlankResponse() };

		var result = extremeIpLookupServiceWrapper.getIp( ipAddress = rc.ipAddress );

		dump( result )
		abort;
	}

}
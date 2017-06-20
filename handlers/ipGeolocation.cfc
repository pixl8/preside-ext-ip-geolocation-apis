component {

	property name="extremeIpLookupServiceWrapper" inject="extremeIpLookupServiceWrapper";
	property name="systemConfigurationService"    inject="systemConfigurationService";

	public any function testAjaxGetIp( event, prc, rc, args={} ) {
		if( !len( rc.ipAddress ?: "" ) ){ event.notFound(); }

		var format = systemConfigurationService.getSetting( "ip_geolocation", "result_format", "json" );
		var result = extremeIpLookupServiceWrapper.getIp( ipAddress = rc.ipAddress );

		if( isStruct( result ) ) {
			event.renderData( type=format, data=result );
		} else {
			event.renderData( type=format, data={ error=true, message="Unknown error occurred. Please check the CMS Admin configuration and verify." } );
		}
	}

	public struct function testGetIp( event, prc, rc, args={} ) {
		if( !len( rc.ipAddress ?: "" ) ){ event.notFound(); }

		var result = extremeIpLookupServiceWrapper.getIp( ipAddress = rc.ipAddress );

		if( isStruct( result ) ) {
			return result;
		} else {
			return { error=true, message="Unknown error occurred. Please check the CMS Admin configuration and verify." };
		}
	}

	public any function proxyGetIp( event, prc, rc, args={} ) {
		if( !len( rc.ipAddress ?: "" ) ){ event.notFound(); }

		var result = extremeIpLookupServiceWrapper.getIp( ipAddress = rc.ipAddress );

		dump( result )
		abort;
	}

}
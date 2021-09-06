/**
 * @expressionCategory location
 * @expressionContexts webrequest
 */
component {

	property name="extremeIpLookupServiceWrapper" inject="extremeIpLookupServiceWrapper";
	property name="ipwhoisIpLookupServiceWrapper" inject="ipwhoisIpLookupServiceWrapper";
	property name="systemConfigurationService"    inject="systemConfigurationService";

	private boolean function evaluateExpression(
		  string city    = ""
		, string _stringOperator = "contains"
	) {
		var config      = systemConfigurationService.getCategorySettings( "ip_geolocation" )
		var userIp      = event.getClientIp();
		var extIpResult = {};

		if( userIp == "127.0.0.1" ) {
			http url=config.extip_service_endpoint result="extIpResult" timeout=config.extip_serviceapi_call_timeout;
			userIp  = deserializeJSON( extIpResult.filecontent ).IP ?: "";
		}

		var result = {}

		if( IsIPv6( userIp ) ){
			result = ipwhoisIpLookupServiceWrapper.getIpLookupFromCache( ipAddress=userIp );
		} else {
			result = extremeIpLookupServiceWrapper.getIpLookupFromCache( ipAddress=userIp );
		}

		var cityLocation = result.city ?: "";

		switch ( arguments._stringOperator ) {
			case "eq"            : return cityLocation == arguments.city;
			case "neq"           : return cityLocation != arguments.city;
			case "contains"      : return cityLocation.findNoCase( arguments.city ) > 0;
			case "notcontains"   : return cityLocation.findNoCase( arguments.city ) == 0;
			case "startsWith"    : return cityLocation.left( Len( arguments.city ) ) == arguments.city;
			case "notstartsWith" : return cityLocation.left( Len( arguments.city ) ) != arguments.city;
			case "endsWith"      : return cityLocation.right( Len( arguments.city ) ) == arguments.city;
			case "notendsWith"   : return cityLocation.right( Len( arguments.city ) ) != arguments.city;
		}
	}

}

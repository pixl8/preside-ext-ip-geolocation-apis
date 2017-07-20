/**
 * @expressionCategory location
 * @expressionContexts webrequest
 */
component {

	property name="extremeIpLookupServiceWrapper" inject="extremeIpLookupServiceWrapper";
	property name="systemConfigurationService"    inject="systemConfigurationService";

	private boolean function evaluateExpression(
		  string region    = ""
		, string _stringOperator = "contains"
	) {
		var config      = systemConfigurationService.getCategorySettings( "ip_geolocation" )
		var userIp      = event.getClientIp();
		var extIpResult = {};

		if( userIp == "127.0.0.1" ) {
			http url=config.extip_service_endpoint result="extIpResult" timeout=config.extip_serviceapi_call_timeout;
			userIp  = deserializeJSON( extIpResult.filecontent ).IP;
		}

		var result = extremeIpLookupServiceWrapper.getIpLookupFromCache( ipAddress=userIp );

		var regionLocation = result.region ?: "";

		switch ( arguments._stringOperator ) {
			case "eq"            : return regionLocation == arguments.region;
			case "neq"           : return regionLocation != arguments.region;
			case "contains"      : return regionLocation.findNoCase( arguments.region ) > 0;
			case "notcontains"   : return regionLocation.findNoCase( arguments.region ) == 0;
			case "startsWith"    : return regionLocation.left( Len( arguments.region ) ) == arguments.region;
			case "notstartsWith" : return regionLocation.left( Len( arguments.region ) ) != arguments.region;
			case "endsWith"      : return regionLocation.right( Len( arguments.region ) ) == arguments.region;
			case "notendsWith"   : return regionLocation.right( Len( arguments.region ) ) != arguments.region;
		}
	}

}

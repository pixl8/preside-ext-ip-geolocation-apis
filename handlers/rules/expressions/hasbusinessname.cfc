/**
 * @expressionCategory location
 * @expressionContexts webrequest
 */
component {

	property name="extremeIpLookupServiceWrapper" inject="extremeIpLookupServiceWrapper";
	property name="systemConfigurationService"    inject="systemConfigurationService";

	private boolean function evaluateExpression(
		  string businessName    = ""
		, string _stringOperator = "contains"
	) {
		var config      = systemConfigurationService.getCategorySettings( "ip_geolocation" )
		var userIp      = event.getClientIp();
		var extIpResult = {};

		if( userIp == "127.0.0.1" ) {
			http url=config.extip_service_endpoint result="extIpResult" timeout=config.extip_serviceapi_call_timeout;
			userIp  = deserializeJSON( extIpResult.filecontent ).IP ?: "";
		}

		var result = extremeIpLookupServiceWrapper.getIpLookupFromCache( ipAddress=userIp );

		var businessNameLocation = result.businessName ?: "";

		switch ( arguments._stringOperator ) {
			case "eq"            : return businessNameLocation == arguments.businessName;
			case "neq"           : return businessNameLocation != arguments.businessName;
			case "contains"      : return businessNameLocation.findNoCase( arguments.businessName ) > 0;
			case "notcontains"   : return businessNameLocation.findNoCase( arguments.businessName ) == 0;
			case "startsWith"    : return businessNameLocation.left( Len( arguments.businessName ) ) == arguments.businessName;
			case "notstartsWith" : return businessNameLocation.left( Len( arguments.businessName ) ) != arguments.businessName;
			case "endsWith"      : return businessNameLocation.right( Len( arguments.businessName ) ) == arguments.businessName;
			case "notendsWith"   : return businessNameLocation.right( Len( arguments.businessName ) ) != arguments.businessName;
		}
	}

}

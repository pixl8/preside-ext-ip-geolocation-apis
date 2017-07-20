/**
 * @expressionCategory location
 * @expressionContexts webrequest
 */
component {

	property name="extremeIpLookupServiceWrapper" inject="extremeIpLookupServiceWrapper";
	property name="systemConfigurationService"    inject="systemConfigurationService";

	/**
	  * @continent.fieldtype    select
	  * @continent.values       Africa,Antartica,Asia,Australia,Europe,NorthAmerica,SouthAmerica
	  * @continent.labelUriRoot rules.expressions.hascontinent:
	  * @continent.multiple     true
	  */
	private boolean function evaluateExpression(
		  string  continent = ""
		, boolean _is       = true
	) {
		var config      = systemConfigurationService.getCategorySettings( "ip_geolocation" )
		var userIp      = event.getClientIp();
		var extIpResult = {};

		if( userIp == "127.0.0.1" ) {
			http url=config.extip_service_endpoint result="extIpResult" timeout=config.extip_serviceapi_call_timeout;
			userIp  = deserializeJSON( extIpResult.filecontent ).IP;
		}

		var result = extremeIpLookupServiceWrapper.getIpLookupFromCache( ipAddress=userIp );

		return arguments._is == ( arguments.continent.listFindNoCase( result.continent ?: "" ) > 0 );

	}

}

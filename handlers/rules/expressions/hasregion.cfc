/**
 * @expressionCategory location
 * @expressionContexts webrequest
 */
component {

	property name="geoLocationService" inject="geoLocationService";

	private boolean function evaluateExpression(
		  string region    = ""
		, string _stringOperator = "contains"
	) {
		var regionLocation =  geoLocationService.getRegion();

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

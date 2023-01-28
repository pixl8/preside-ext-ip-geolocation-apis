/**
 * @expressionCategory location
 * @expressionContexts webrequest
 */
component {

	property name="geoLocationService" inject="geoLocationService";


	private boolean function evaluateExpression(
		  string businessName    = ""
		, string _stringOperator = "contains"
	) {
		var businessNameLocation = geoLocationService.getBusinessName();

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

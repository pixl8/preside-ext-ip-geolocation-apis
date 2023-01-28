/**
 * @expressionCategory location
 * @expressionContexts webrequest
 */
component {

	property name="geoLocationService" inject="geoLocationService";

	private boolean function evaluateExpression(
		  string city    = ""
		, string _stringOperator = "contains"
	) {
		var cityLocation = geoLocationService.getCity();

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

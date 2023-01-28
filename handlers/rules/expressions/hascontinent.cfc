/**
 * @expressionCategory location
 * @expressionContexts webrequest
 */
component {

	property name="geoLocationService" inject="geoLocationService";

	variables.mappedContintentsForBackwardCompat = {
		  AF = "Africa"
		, NA = "NorthAmerica"
		, OC = "Oceania"
		, AN = "Antartica"
		, AS = "Asia"
		, EU = "Europe"
		, SA = "SouthAmerica"
	};

	/**
	  * @continent.fieldtype    select
	  * @continent.values       Africa,Antartica,Asia,Oceania,Europe,NorthAmerica,SouthAmerica
	  * @continent.labelUriRoot rules.expressions.hascontinent:
	  * @continent.multiple     true
	  */
	private boolean function evaluateExpression(
		  string  continent = ""
		, boolean _is       = true
	) {
		var contintentLocation = geoLocationService.getContinent();

		contintentLocation = mappedContintentsForBackwardCompat[ contintentLocation ] ?: contintentLocation;

		return arguments._is == ListFindNoCase( arguments.continent, contintentLocation ) > 0;
	}

}

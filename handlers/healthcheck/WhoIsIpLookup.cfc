component {
	property name="geoLocationService" inject="geoLocationService";

	private boolean function check() {
		return geoLocationService.isWhoIsAvailable();
	}
}
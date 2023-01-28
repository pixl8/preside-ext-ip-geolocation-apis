component {

	public void function configure( required struct config ) {
		var settings = arguments.config.settings ?: "";

		_configureDefaults( settings );
		_setupHealthcheck( settings );
		_setupFeatures( settings );
		_setupInterceptors( arguments.config );
	}

// PRIVATE HELPERS
	private void function _configureDefaults( settings ) {
		settings.whoisIpLookup = settings.whoisIpLookup ?: {};

		settings.whoisIpLookup.apiKey = settings.whoisIpLookup.apiKey ?: ( settings.env.WHOIS_IP_LOOKUP_API_KEY ?: "" );
	}

	private void function _setupHealthcheck( settings ) {
		settings.healthcheckServices.whoIsIpLookup = {
			interval = CreateTimeSpan( 0, 1, 0, 0 ) // one hour - heathchecks count toward rate limit
		};
	}

	private void function _setupFeatures( settings ) {
		// for local environments: when your traffic is always coming from 127.0.0.1
		// enable this feature to reverse lookup your actual IP for testing purposes

		// note: this is dynamically set for 'local' environment in /interceptors/IpGeolocationApiInterceptors.cfc
		// settings.features.reverseLocalhostIpLookup = { enabled=false };
	}

	private void function _setupInterceptors( config ) {
		config.interceptors = config.interceptors ?: [];

		ArrayAppend( config.interceptors, { class="app.extensions.preside-ext-ip-geolocation-apis.interceptors.IpGeolocationApiInterceptors", properties={} } );
	}


}
component extends="coldbox.system.Interceptor" {

	property name="whoisApiKey"                inject="coldbox:setting:whoisIpLookup.apiKey";
	property name="formsService"               inject="delayedInjector:formsService";
	property name="systemConfigurationService" inject="delayedInjector:systemConfigurationService";

// PUBLIC
	public void function configure() {}

	public void function afterConfigurationLoad( event, interceptData ) {
		_setupIpLookupCache();
		_setupReverseIpLookupDefault();
	}

	public void function onApplicationStart( event, interceptData ) {
		_alterConfigFormWhenApiKeyInCodeConfig();
	}

// HELPERS
	private void function _setupIpLookupCache() {
		var cachebox       = getController().getCachebox();
		var existingCaches = cachebox.getCacheNames();

		if ( !ArrayFindNoCase( existingCaches, "ipLookupCache" ) ) {
			var cache = new preside.system.coldboxModifications.cachebox.CacheProvider();

			cache.setName( "ipLookupCache" );
			cache.setConfiguration({
				  objectDefaultTimeout           = 120
				, objectDefaultLastAccessTimeout = 0
				, useLastAccessTimeouts          = false
				, reapFrequency                  = 60
				, evictionPolicy                 = "LFU"
				, evictCount                     = 500
				, maxObjects                     = 1000
				, objectStore                    = "ConcurrentStore"
			});

			cachebox.addCache( cache );
		}
	}

	private void function _alterConfigFormWhenApiKeyInCodeConfig() {
		if ( Len( whoisApiKey ) ) {
			var newFormName = formsService.createForm( basedOn="system-config.ip_geolocation", generator=function( frm ){
				frm.modifyField(
					  tab         = "default"
					, fieldset    = "api"
					, name        = "whois_api_key"
					, disabled    = true
					, placeholder = "system-config.ip_geolocation:field.whois_api_key.disabled.placeholder"
				);
			} );

			systemConfigurationService.getConfigCategory( "ip_geolocation" ).setForm( newFormName );
		}
	}

	private void function _setupReverseIpLookupDefault() {
		if ( getController().getSetting( "environment" ) == "local" ) {
			var settings = getController().getSettingStructure();

			settings.features.reverseLocalhostIpLookup = settings.features.reverseLocalhostIpLookup ?: { enabled=true };
		}
	}

}
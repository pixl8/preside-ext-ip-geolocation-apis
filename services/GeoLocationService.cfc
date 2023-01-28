/**
 * @presideService true
 * @singleton      true
 */
component {

	property name="defaultApiKey" inject="coldbox:setting:whoisIpLookup.apiKey";
	property name="whoisApi"      inject="whoisApi@cbwhois";
	property name="ipLookupCache" inject="cachebox:ipLookupCache";

	variables._commonHeaders = {
		  city      = [ "cf-ipcity"]
		, country   = [ "cf-ipcountry"]
		, lat       = [ "cf-iplatitude"]
		, lon       = [ "cf-iplongitude"]
		, continent = [ "cf-ipcontinent" ]
	};

// CONSTRUCTOR
	public any function init() {
		return this;
	}

// PUBLIC API METHODS
	public string function getBusinessName() {
		return _get( "businessName" );
	}

	public string function getCity() {
		return _get( "city" );
	}

	public string function getRegion() {
		return _get( "region" );
	}

	public string function getCountryCode() {
		return _get( "country" );
	}

	public string function getContinent() {
		return _get( "continent" );
	}

	public string function getLat() {
		return _get( "lat" );
	}
	public string function getLon() {
		return _get( "lon" );
	}

	public boolean function isWhoIsAvailable() {
		try {
			var apiKey = _getApiKey();
			var result = whoisApi.lookup(
				  ipAddress = ""
				, fields    = "success,rate"
				, apiKey    = _getApiKey()
			);

			if ( !$helpers.isTrue( result.success ) ) {
				throw(
					  type    = "whois.service.unavailable"
					, message = "Non successful response from server: [#( result.message )#]"
				);
			}
			if ( Len( apiKey ) && !Val( result.rate.remaining ?: "" ) ) {
				throw(
					  type    = "whois.service.unavailable"
					, message = "Rate limit exceeded"
					, detail  = SerializeJson( result )
				);
			}
		} catch( any e ) {
			$raiseError( e );
			return false;
		}

		return true;
	}

// PRIVATE HELPERS
	private string function _get( entity ) {
		var value = _commonFastGets( arguments.entity );

		if ( !Len( value ) ) {
			var lookupDataByIp = _lookupDataByIp();
			value = lookupDataByIp[ arguments.entity ] ?: "";
		}

		return value;
	}

	private string function _commonFastGets( entity ) {
		request._geoLocationCache = request._geoLocationCache ?: {};

		if ( StructKeyExists( request._geoLocationCache, arguments.entity ) ) {
			return request._geoLocationCache[ arguments.entity ];
		}

		var headersToCheck = _getHeadersToCheck( arguments.entity );
		if ( ArrayLen( headersToCheck ) ) {
			var headers = getHttpRequestData( false ).headers;
			for( var headerName in headersToCheck ) {
				if ( Len( headers[ headerName ] ?: "" ) ) {
					request._geoLocationCache[ arguments.entity ] = headers[ headersToCheck ];
					return headers[ headersToCheck ];
				}
			}
		}

		return "";
	}

	private array function _getHeadersToCheck( entity ) {
		var toCheck    = [];
		var common     = variables._commonHeaders[ arguments.entity ] ?: [];
		var configured = ListToArray( $getPresideSetting( "ip_geolocation", "#arguments.entity#_headers" ), ",#Chr(10)##Chr(13)# " );

		ArrayAppend( toCheck, common, true );
		ArrayAppend( toCheck, configured, true );

		return toCheck;
	}

	private struct function _lookupDataByIp() {
		var ipAddress = _getIp();
		var data      = ipLookupCache.get( ipAddress );

		if ( IsNull( local.data ) ) {
			data = {};

			if ( !_isLocalIp( ipAddress ) && $isUp( "whoIsIpLookup" ) ) {
				try {
					data = whoisApi.lookup(
						  ipAddress = ipAddress
						, apiKey    = _getApiKey()
						, fields    = "success,continent_code,country_code,region,city,latitude,longitude,connection.org,latitude,longitude"
					);

					if ( $helpers.isTrue( data.success ?: "" ) ) {
						data = {
							  businessName = ( data.connection.org ?: "" )
							, city         = ( data.city           ?: "" )
							, region       = ( data.region         ?: "" )
							, country      = ( data.country_code   ?: "" )
							, continent    = ( data.continent_code ?: "" )
							, lat          = ( data.latitude       ?: "" )
							, lon          = ( data.longitude      ?: "" )
						};
						ipLookupCache.set( ipAddress, data );

					} else {
						throw( type="who.is.lookup.failure", message="Error returned from who.is: [#( data.message ?: '' )#]", detail=SerializeJson( data ) );
					}

				} catch( any e ) {
					$raiseError( e );
				}
			}
		}

		return data;
	}

	private string function _getApiKey() {
		if ( Len( defaultApiKey ) ) {
			return defaultApiKey;
		}

		return $getPresideSetting( "ip_geolocation", "whois_api_key" );
	}

	private string function _getIp() {
		var ip = $getRequestContext().getClientIp();

		if ( _isLocalIp( ip ) && $isFeatureEnabled( "reverseLocalhostIpLookup" ) ) {
			ip = _lookupLocalIp();
		}

		return ip;
	}

	private string function _lookupLocalIp() {
		if ( !StructKeyExists( variables, "_localIp" ) ) {
			try {
				var result = "";
				http url="http://api.ipify.org/" result="result" timeout=10 throwonerror=true;
				variables._localIp = Trim( result.fileContent );
			} catch( any e ) {
				$raiseErrror( e );
				variables._localIp = "127.0.0.1";
			}
		}

		return variables._localIp;
	}

	private boolean function _isLocalIp( ip ) {
		// TODO: make this better
		return ReFind( "^(10|127|172)\.", arguments.ip )

}
}
component extends="testbox.system.BaseSpec" {

	function run(){

		describe( "getBusinessName()", function() {
			beforeEach( function(){ _setup(); } );
			afterEach( function() { _tearDown(); } );

			it( "should get business name from configured header when available", function(){
				sut.$( "_getHeadersToCheck" ).$args( "businessname" ).$results( [ "test1", "X-Test-Header", "X-Business" ] );

				expect( sut.getBusinessName() ).toBe( "Test value" );
			} );

			it( "should get business name from cached ip lookup when available and not in headers", function(){
				mockIpLookupCache.$( "get" ).$args( randomTestIp ).$results( { businessName="Test biz" } );

				expect( sut.getBusinessName() ).toBe( "Test biz" );
				expect( ArrayLen( mockWhoIsApi.$callLog().lookup ?: [] ) ).toBe( 0 );
			} );

			it( "should get business name from whois lookup when not in headers or cache", function(){
				expect( sut.getBusinessName() ).toBe( mockApiResult.connection.org );

				expect( ArrayLen( mockIpLookupCache.$callLog().set ?: [] ) ).toBe( 1 );
				expect( mockIpLookupCache.$callLog().set[ 1 ] ).toBe( [ randomTestIp, mockApiResultConverted ] );
			} );
		} );

		describe( "getCity()", function() {
			beforeEach( function(){ _setup(); } );
			afterEach( function() { _tearDown(); } );

			it( "should get city from configured header when available", function(){
				sut.$( "_getHeadersToCheck" ).$args( "city" ).$results( [ "test1", "X-Test-Header", "X-Business" ] );

				expect( sut.getCity() ).toBe( "Test value" );
			} );

			it( "should get city from cached ip lookup when available and not in headers", function(){
				mockIpLookupCache.$( "get" ).$args( randomTestIp ).$results( { city="City from cache" } );

				expect( sut.getCity() ).toBe( "City from cache" );
				expect( ArrayLen( mockWhoIsApi.$callLog().lookup ?: [] ) ).toBe( 0 );
			} );

			it( "should get city from whois lookup when not in headers or cache", function(){
				expect( sut.getCity() ).toBe( mockApiResult.city );

				expect( ArrayLen( mockIpLookupCache.$callLog().set ?: [] ) ).toBe( 1 );
				expect( mockIpLookupCache.$callLog().set[ 1 ] ).toBe( [ randomTestIp, mockApiResultConverted ] );
			} );
		} );

		describe( "getRegion()", function() {
			beforeEach( function(){ _setup(); } );
			afterEach( function() { _tearDown(); } );

			it( "should get region from configured header when available", function(){
				sut.$( "_getHeadersToCheck" ).$args( "region" ).$results( [ "test1", "X-Test-Header", "X-Business" ] );

				expect( sut.getRegion() ).toBe( "Test value" );
			} );

			it( "should get region from cached ip lookup when available and not in headers", function(){
				mockIpLookupCache.$( "get" ).$args( randomTestIp ).$results( { region="Test region from cache" } );

				expect( sut.getRegion() ).toBe( "Test region from cache" );
				expect( ArrayLen( mockWhoIsApi.$callLog().lookup ?: [] ) ).toBe( 0 );
			} );

			it( "should get region from whois lookup when not in headers or cache", function(){
				expect( sut.getRegion() ).toBe( mockApiResult.region );

				expect( ArrayLen( mockIpLookupCache.$callLog().set ?: [] ) ).toBe( 1 );
				expect( mockIpLookupCache.$callLog().set[ 1 ] ).toBe( [ randomTestIp, mockApiResultConverted ] );
			} );
		} );

		describe( "getCountryCode()", function() {
			beforeEach( function(){ _setup(); } );
			afterEach( function() { _tearDown(); } );

			it( "should get country code from configured header when available", function(){
				sut.$( "_getHeadersToCheck" ).$args( "country" ).$results( [ "test1", "X-Test-Header", "X-Business" ] );

				expect( sut.getCountryCode() ).toBe( "Test value" );
			} );

			it( "should get country code from cached ip lookup when available and not in headers", function(){
				mockIpLookupCache.$( "get" ).$args( randomTestIp ).$results( { country="Test country from cache" } );

				expect( sut.getCountryCode() ).toBe( "Test country from cache" );
				expect( ArrayLen( mockWhoIsApi.$callLog().lookup ?: [] ) ).toBe( 0 );
			} );

			it( "should get country code from whois lookup when not in headers or cache", function(){
				expect( sut.getCountryCode() ).toBe( mockApiResult.country_code );

				expect( ArrayLen( mockIpLookupCache.$callLog().set ?: [] ) ).toBe( 1 );
				expect( mockIpLookupCache.$callLog().set[ 1 ] ).toBe( [ randomTestIp, mockApiResultConverted ] );
			} );
		} );

		describe( "getContinent()", function() {
			beforeEach( function(){ _setup(); } );
			afterEach( function() { _tearDown(); } );

			it( "should get continent from configured header when available", function(){
				sut.$( "_getHeadersToCheck" ).$args( "continent" ).$results( [ "test1", "X-Test-Header", "X-Business" ] );

				expect( sut.getContinent() ).toBe( "Test value" );
			} );

			it( "should get continent from cached ip lookup when available and not in headers", function(){
				mockIpLookupCache.$( "get" ).$args( randomTestIp ).$results( { continent="Test continent from cache" } );

				expect( sut.getContinent() ).toBe( "Test continent from cache" );
				expect( ArrayLen( mockWhoIsApi.$callLog().lookup ?: [] ) ).toBe( 0 );
			} );

			it( "should get continent from whois lookup when not in headers or cache", function(){
				expect( sut.getContinent() ).toBe( mockApiResult.continent_code );

				expect( ArrayLen( mockIpLookupCache.$callLog().set ?: [] ) ).toBe( 1 );
				expect( mockIpLookupCache.$callLog().set[ 1 ] ).toBe( [ randomTestIp, mockApiResultConverted ] );
			} );
		} );


		describe( "getLat()", function() {
			beforeEach( function(){ _setup(); } );
			afterEach( function() { _tearDown(); } );

			it( "should get latitude from configured header when available", function(){
				sut.$( "_getHeadersToCheck" ).$args( "lat" ).$results( [ "test1", "X-Test-Header", "X-Business" ] );

				expect( sut.getLat() ).toBe( "Test value" );
			} );

			it( "should get latitude from cached ip lookup when available and not in headers", function(){
				mockIpLookupCache.$( "get" ).$args( randomTestIp ).$results( { lat="Test lat from cache" } );

				expect( sut.getLat() ).toBe( "Test lat from cache" );
				expect( ArrayLen( mockWhoIsApi.$callLog().lookup ?: [] ) ).toBe( 0 );
			} );

			it( "should get latitude from whois lookup when not in headers or cache", function(){
				expect( sut.getLat() ).toBe( mockApiResult.latitude );

				expect( ArrayLen( mockIpLookupCache.$callLog().set ?: [] ) ).toBe( 1 );
				expect( mockIpLookupCache.$callLog().set[ 1 ] ).toBe( [ randomTestIp, mockApiResultConverted ] );
			} );
		} );

		describe( "getLon()", function() {
			beforeEach( function(){ _setup(); } );
			afterEach( function() { _tearDown(); } );

			it( "should get longitude from configured header when available", function(){
				sut.$( "_getHeadersToCheck" ).$args( "lon" ).$results( [ "test1", "X-Test-Header", "X-Business" ] );

				expect( sut.getLon() ).toBe( "Test value" );
			} );

			it( "should get longitude from cached ip lookup when available and not in headers", function(){
				mockIpLookupCache.$( "get" ).$args( randomTestIp ).$results( { lon="Test lon from cache" } );

				expect( sut.getLon() ).toBe( "Test lon from cache" );
				expect( ArrayLen( mockWhoIsApi.$callLog().lookup ?: [] ) ).toBe( 0 );
			} );

			it( "should get longitude from whois lookup when not in headers or cache", function(){
				expect( sut.getLon() ).toBe( mockApiResult.longitude );

				expect( ArrayLen( mockIpLookupCache.$callLog().set ?: [] ) ).toBe( 1 );
				expect( mockIpLookupCache.$callLog().set[ 1 ] ).toBe( [ randomTestIp, mockApiResultConverted ] );
			} );
		} );



	}

	private void function _setup() {
		variables.sut                = createMock( object=new geo.services.GeoLocationService() );
		variables.mockWhoIsApi       = createStub();
		variables.mockIpLookupCache  = createStub();
		variables.randomTestIp       = "211.3.55.123";
		variables.testApiKey         = "test-api-key";
		variables.mockHeaders        = { "Header-1"="test", "X-Test-Header"="Test value", "X-Another-Header"="Another value" };
		variables.mockApiResult      = {
			  success        = true
			, continent_code = "EU"
			, country_code   = "GB"
			, region         = "Test region from who.is"
			, city           = "Test city from who.is"
			, latitude       = 300
			, longitude      = 500
			, connection     = { org="Org from who.is" }
		};
		variables.mockApiResultConverted = {
			  continent    = "EU"
			, country      = "GB"
			, region       = "Test region from who.is"
			, city         = "Test city from who.is"
			, lat          = 300
			, lon          = 500
			, businessName = "Org from who.is"
		};

		sut.setDefaultApiKey( testApiKey );
		sut.setWhoisApi( mockWhoIsApi );
		sut.setIpLookupCache( mockIpLookupCache );

		sut.$( "_getIp", randomTestIp );
		sut.$( "_getHeaders", mockHeaders );
		sut.$( "_getHeadersToCheck", [] );
		sut.$( "$isUp" ).$args( "whoIsIpLookup" ).$results( true );
		mockIpLookupCache.$( "get", NullValue() );
		mockIpLookupCache.$( "set" );
		mockWhoIsApi.$( "lookup" ).$args(
			  ipAddress = randomTestIp
			, apiKey    = testApiKey
			, fields    = "success,continent_code,country_code,region,city,latitude,longitude,connection.org"
		).$results( mockApiResult );
	}

	private void function _teardown() {
		request._geoLocationCache = {};
	}

}
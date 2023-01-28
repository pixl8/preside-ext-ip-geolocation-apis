# IP Geolocation APIs for Preside

_Using who.is IP lookup for extended geolocation data._

## About

The IP Geolocation APIs extension provides:

* **Preside users** with a set of rules engine expressions to use in dyanmic conditional content/access rules. e.g. "Visitor's country is 'UK'"
* **Developers** with an interface to get a visitors geo location data

It reads geolocation data from two sources:

1. Common headers (e.g. Cloudflare geolocation headers) - _these can also be extended by admins in the configuration form_
2. [https://ipwhois.io/](https://ipwhois.io/) API (only when values not found in headers)

## Installation

Install the extension with:

```
box install preside-ext-ip-geolocation-apis
```

## Using the rules engine expressions

Once installed, users will immediately be able to build rules engine conditions using the "Visitor location" group of expressions.

**These apply only to "web request" based conditions** - they will not work in email content, for example.

## Configuration

### API key

The extension gets uses the [https://ipwhois.io/](https://ipwhois.io/) API to perform lookup calls to get extended geolocation data when not found in http headers. While you can use this API without a paid for API key, the usage is limited. Configuration of an API key can be provided in two ways:

* Developer provided, via `settings.whoisIpLookup.apiKey` variables **or** `WHOIS_IP_LOOKUP_API_KEY` [environment variable](https://docs.preside.org/devguides/config.html#injecting-environment-variables)
* Preside admin user provided: if no developer key is provided, users can navigate to **System settings -> IP Geolocation API settings** and enter an API key there

### Caching

The extension uses a [Cachebox cache](https://cachebox.ortusbooks.com/) named `ipLookupCache` to cache results of IP lookups. If you wish to configure your own cache, define your own cache in your application's `/config/Cachebox.cfc` file named `ipLookupCache`.

### Extending header detection

By default, the system checks for Cloudflare headers in the form `cf-ipcountry`, `cf-iplongitude`, etc. If you wish to use different/more headers, these can be specified in the admin via **System settings -> IP Geolocation API settings** in the "Advanced" tab.

## Developer API

If developers wish to use the extension to check geo location data, they should do so via the `geoLocationService` service component. Examples:

```cfc

property name="geoLocationService" inject="geoLocationService";

// ...

var region = geoLocationService.getRegion();

if ( region == "England" ) {
	// ...
}

// see also:
geoLocationService.getCity();
geoLocationService.getRegion();
geoLocationService.getCountryCode();
geoLocationService.getContinent();
geoLocationService.getLat();
geoLocationService.getLon();
geoLocationService.getBusinessName();
```

## Versioning

We use [SemVer](https://semver.org) for versioning. For the versions available, see the [tags on this repository](https://github.com/pixl8/preside-ext-ip-geolocation-apis/releases). Project releases can also be found and installed from [Forgebox](https://forgebox.io/view/preside-ext-ip-geolocation-apis)

## License

This project is licensed under the GPLv2 License - see the [LICENSE.txt](https://github.com/pixl8/preside-ext-ip-geolocation-apis/blob/stable/LICENSE.txt) file for details.

## Authors

The project is maintained by [The Pixl8 Group](https://www.pixl8.co.uk). The lead developer is [Dominic Watson](https://github.com/DominicWatson).

## Code of conduct

We are a small, friendly and professional community. For the eradication of doubt, we publish a simple [code of conduct](https://github.com/pixl8/preside-ext-ip-geolocation-apis/blob/stable/CODE_OF_CONDUCT.md) and expect all contributors, users and passers-by to observe it.
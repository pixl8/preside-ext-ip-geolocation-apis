# Preside IP Geolocation APIs Extension
Preside extension to allow application developers to get all geolocation information about an IP address in a number of different formats.

Mainly developed for use with the https://extreme-ip-lookup.com/ IP Geolocation service but can be adapted to another provider.

Simply configure the API settings and that should be all you need.  Examples are given in the CMS Admin Settings form.

## IMPORTANT NOTE
The https://extreme-ip-lookup.com/ IP Geolocation service now *requires an API key* so please register an account there first before configuring.

There is still a free plan but the calls will be rejected if not made with a valid API key which can simply be added in the CMS Admin settings.

## IPv4 and IPv6 Support
The initial service provider Extreme IP Lookup does not currently support IPv6 address format lookups therefore the extension was extended to include
an additional service https://ipwhois.io/ which provides the same level of accuracy but acts as a backup if the visitors IP address format is not IPv4.

## Installation
Install the extension to your application via either of the methods detailed below (Git submodule / CommandBox + ForgeBox)

### Git Submodule method
From the root of your application, type the following command:

	git submodule add https://github.com/nodoherty/preside-ext-ip-geolocation-apis.git application/extensions/preside-ext-ip-geolocation-apis

### CommandBox (box.json) method
From the root of your application type the following command:

	box install preside-ext-ip-geolocation-apis

From the Preside CMS developer console (using the back tick ` key) reload the application:
	reload all

### Enabling the extension
Once the files are installed, enable the extension by reloading the application:

	reload all --force

## Usage
See the included handler `ipGeolocation.cfc` for examples of calling directly via ColdFusion server code or via AJAX

You can use the text method to see debug output for the API calls, simply update your IP Address in the URL below:
`?event=ipGeolocation.proxyGetIp&test_ip_address=78.155.228.144`
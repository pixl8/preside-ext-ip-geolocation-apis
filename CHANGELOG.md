# Changelog

## 2.0.0

Overhaul of the system:

* Scrap use of extremeIp lookup API
* Scrap public debug handler for ip lookups
* Use who.is api exclusively (using a separate open source module for its API)
* Refactor API to focus on getting individual information points, e.g. getCountry(), etc.
* Check common Cloudflare HTTP headers for geo location information where possible, avoiding API lookups
* Introduce a cachebox cache for IP lookups
* Introduce a preside healthcheck service for the API - if it goes down or we have network connectivity issues, do not block requests

## 1.3.4
* Adding debug output for the test method proxyGetIp()

## 1.3.3
* Fixing bug with getting the API key - removed incorrect Val()
* Adding the ability to pass a test IP address in the URL using parameter `test_ip_address`
* Adding check for the existence of a leading "/" in the endpoint URL, adding if missing
* Adding API Key parameter "key=" to the URL for the extreme IP lookup service as per their updated docs - https://extreme-ip-lookup.com/
* Updated README with notes on the new requirement for the API key

## 1.3.2 & 1.3.1
* Adding cache lookups for the IPv6 addresses to the rules engine expressions
* Bumping the version numbers

## 1.3.0
* Adding new service for IPv6 support
* Adding caching to help with remain within 3rd party API rate limits
* Changelog added

## 1.2.7
* Fixing typo and updating instructions + bumping version numbers

## 1.2.5
* Updating extension to allow for smaller HTTP call timeout values
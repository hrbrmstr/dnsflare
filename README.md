
# dnsflare

Query ‘Cloudflare’ Domain Name System (‘DNS’) Servers over ‘HTTPS’

## Description

Domain Name System (‘DNS’) queries are generally perfomed by operating
system calls when browsing the internet or making other network
connectios. DNS over ‘HTTPS’ services offer more local confidentiality
and some ‘DNS’ providers like Cloudflare offer
(<https://developers.cloudflare.com/1.1.1.1/dns-over-https/json-format/>)
an ‘API’-like service along with other privacy-enabled ‘DNS’ offerings.
Tools are provided to query this ‘DNS’ ‘API’.

## What’s Inside The Tin

The following functions are implemented:

  - `query`: Make a single DNS query
  - `valid_dns_types`: Valid DNS types

## TODO

  - `batch_query()` method
  - `as.data.frame()` method

## Installation

``` r
devtools::install_github("hrbrmstr/dnsflare")
```

## Usage

``` r
library(dnsflare)

# current verison
packageVersion("dnsflare")
```

    ## [1] '0.1.0'

## Queries

``` r
query("rud.is")
```

    ## Question:
    ## 
    ##   type    name value        meaning
    ## 1    1 rud.is.     A a host address
    ## 
    ## Answer:
    ## 
    ##   type    name  TTL            data value        meaning
    ## 1    1 rud.is. 1716 104.236.112.222     A a host address
    ## 
    ## Status: No Error | Recursive Desired | Recursive Available

``` r
query("example.com", "A")
```

    ## Question:
    ## 
    ##   type         name value        meaning
    ## 1    1 example.com.     A a host address
    ## 
    ## Answer:
    ## 
    ##   type         name  TTL          data value        meaning
    ## 1    1 example.com. 1540 93.184.216.34     A a host address
    ## 
    ## Status: No Error | Recursive Desired | Recursive Available | DNSSEC Verified

``` r
query("microsoft.com", "MX")
```

    ## Question:
    ## 
    ##   type           name value       meaning
    ## 1   15 microsoft.com.    MX mail exchange
    ## 
    ## Answer:
    ## 
    ##   type           name  TTL                                          data value       meaning
    ## 1   15 microsoft.com. 3251 10 microsoft-com.mail.protection.outlook.com.    MX mail exchange
    ## 
    ## Status: No Error | Recursive Desired | Recursive Available

``` r
# query("google-public-dns-a.google.com", "TXT") # CURRENTLY BROKEN ON CLOUDFLARE'S END

query("apple.com")
```

    ## Question:
    ## 
    ##   type       name value        meaning
    ## 1    1 apple.com.     A a host address
    ## 
    ## Answer:
    ## 
    ##   type       name TTL          data value        meaning
    ## 1    1 apple.com. 791 17.142.160.59     A a host address
    ## 2    1 apple.com. 791 17.172.224.47     A a host address
    ## 3    1 apple.com. 791  17.178.96.59     A a host address
    ## 
    ## Status: No Error | Recursive Desired | Recursive Available

``` r
query("17.142.160.59", "PTR")
```

    ## Question:
    ## 
    ##   type                        name value               meaning
    ## 1   12 59.160.142.17.in-addr.arpa.   PTR a domain name pointer
    ## 
    ## Answer:
    ## 
    ##    type                        name  TTL                           data value               meaning
    ## 1    12 59.160.142.17.in-addr.arpa. 3600                       mac.one.   PTR a domain name pointer
    ## 2    12 59.160.142.17.in-addr.arpa. 3600                      imac.one.   PTR a domain name pointer
    ## 3    12 59.160.142.17.in-addr.arpa. 3600                     ipad.host.   PTR a domain name pointer
    ## 4    12 59.160.142.17.in-addr.arpa. 3600                     ubnw.info.   PTR a domain name pointer
    ## 5    12 59.160.142.17.in-addr.arpa. 3600                      apple.by.   PTR a domain name pointer
    ## 6    12 59.160.142.17.in-addr.arpa. 3600                     apple.com.   PTR a domain name pointer
    ## 7    12 59.160.142.17.in-addr.arpa. 3600                     apple.xyz.   PTR a domain name pointer
    ## 8    12 59.160.142.17.in-addr.arpa. 3600                     chomp.com.   PTR a domain name pointer
    ## 9    12 59.160.142.17.in-addr.arpa. 3600                      swell.am.   PTR a domain name pointer
    ## 10   12 59.160.142.17.in-addr.arpa. 3600                     icloud.ch.   PTR a domain name pointer
    ## 11   12 59.160.142.17.in-addr.arpa. 3600                     icloud.es.   PTR a domain name pointer
    ## 12   12 59.160.142.17.in-addr.arpa. 3600                     icloud.fr.   PTR a domain name pointer
    ## 13   12 59.160.142.17.in-addr.arpa. 3600                     icloud.om.   PTR a domain name pointer
    ## 14   12 59.160.142.17.in-addr.arpa. 3600                     icloud.se.   PTR a domain name pointer
    ## 15   12 59.160.142.17.in-addr.arpa. 3600                   iphone.host.   PTR a domain name pointer
    ## 16   12 59.160.142.17.in-addr.arpa. 3600                  itunes.earth.   PTR a domain name pointer
    ## 17   12 59.160.142.17.in-addr.arpa. 3600                   macosx.info.   PTR a domain name pointer
    ## 18   12 59.160.142.17.in-addr.arpa. 3600                    openni.org.   PTR a domain name pointer
    ## 19   12 59.160.142.17.in-addr.arpa. 3600                   yessql.info.   PTR a domain name pointer
    ## 20   12 59.160.142.17.in-addr.arpa. 3600              airport.brussels.   PTR a domain name pointer
    ## 21   12 59.160.142.17.in-addr.arpa. 3600                   appleid.org.   PTR a domain name pointer
    ## 22   12 59.160.142.17.in-addr.arpa. 3600                   icloude.com.   PTR a domain name pointer
    ## 23   12 59.160.142.17.in-addr.arpa. 3600                   icloudo.com.   PTR a domain name pointer
    ## 24   12 59.160.142.17.in-addr.arpa. 3600                  ipadpro.buzz.   PTR a domain name pointer
    ## 25   12 59.160.142.17.in-addr.arpa. 3600                 airtunes.info.   PTR a domain name pointer
    ## 26   12 59.160.142.17.in-addr.arpa. 3600                 applepay.info.   PTR a domain name pointer
    ## 27   12 59.160.142.17.in-addr.arpa. 3600                  appleweb.net.   PTR a domain name pointer
    ## 28   12 59.160.142.17.in-addr.arpa. 3600                 powermac.info.   PTR a domain name pointer
    ## 29   12 59.160.142.17.in-addr.arpa. 3600                 sherlock.info.   PTR a domain name pointer
    ## 30   12 59.160.142.17.in-addr.arpa. 3600                 skyvines.info.   PTR a domain name pointer
    ## 31   12 59.160.142.17.in-addr.arpa. 3600                appleexpo.info.   PTR a domain name pointer
    ## 32   12 59.160.142.17.in-addr.arpa. 3600                 camelphat.com.   PTR a domain name pointer
    ## 33   12 59.160.142.17.in-addr.arpa. 3600                powerbook.info.   PTR a domain name pointer
    ## 34   12 59.160.142.17.in-addr.arpa. 3600                 apples-msk.ru.   PTR a domain name pointer
    ## 35   12 59.160.142.17.in-addr.arpa. 3600               appleshare.info.   PTR a domain name pointer
    ## 36   12 59.160.142.17.in-addr.arpa. 3600                ripmixburn.com.   PTR a domain name pointer
    ## 37   12 59.160.142.17.in-addr.arpa. 3600               webobjects.info.   PTR a domain name pointer
    ## 38   12 59.160.142.17.in-addr.arpa. 3600              applecentre.info.   PTR a domain name pointer
    ## 39   12 59.160.142.17.in-addr.arpa. 3600              applescript.info.   PTR a domain name pointer
    ## 40   12 59.160.142.17.in-addr.arpa. 3600              quicktimetv.info.   PTR a domain name pointer
    ## 41   12 59.160.142.17.in-addr.arpa. 3600              alchemysynth.com.   PTR a domain name pointer
    ## 42   12 59.160.142.17.in-addr.arpa. 3600             applemasters.info.   PTR a domain name pointer
    ## 43   12 59.160.142.17.in-addr.arpa. 3600        pv-apple-com.apple.com.   PTR a domain name pointer
    ## 44   12 59.160.142.17.in-addr.arpa. 3600            quicktimelive.info.   PTR a domain name pointer
    ## 45   12 59.160.142.17.in-addr.arpa. 3600            shopdifferent.info.   PTR a domain name pointer
    ## 46   12 59.160.142.17.in-addr.arpa. 3600           searchads-apple.com.   PTR a domain name pointer
    ## 47   12 59.160.142.17.in-addr.arpa. 3600         applecomputerinc.info.   PTR a domain name pointer
    ## 48   12 59.160.142.17.in-addr.arpa. 3600         applepaysupplies.info.   PTR a domain name pointer
    ## 49   12 59.160.142.17.in-addr.arpa. 3600          camelspaceeffect.com.   PTR a domain name pointer
    ## 50   12 59.160.142.17.in-addr.arpa. 3600 applepaymerchantsupplies.info.   PTR a domain name pointer
    ## 
    ## Status: No Error | Recursive Desired | Recursive Available

## Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](CONDUCT.md). By participating in this project you agree to
abide by its terms.

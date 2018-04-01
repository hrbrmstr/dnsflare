
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
  - \`valid\_dns\_types: Valid DNS types

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
str(query("rud.is"))
```

    ## List of 8
    ##  $ Status  : int 0
    ##  $ TC      : logi FALSE
    ##  $ RD      : logi TRUE
    ##  $ RA      : logi TRUE
    ##  $ AD      : logi FALSE
    ##  $ CD      : logi FALSE
    ##  $ Question:'data.frame':    1 obs. of  2 variables:
    ##   ..$ name: chr "rud.is."
    ##   ..$ type: int 1
    ##  $ Answer  :'data.frame':    1 obs. of  4 variables:
    ##   ..$ name: chr "rud.is."
    ##   ..$ type: int 1
    ##   ..$ TTL : int 942
    ##   ..$ data: chr "104.236.112.222"

``` r
str(query("example.com", "A")) 
```

    ## List of 8
    ##  $ Status  : int 0
    ##  $ TC      : logi FALSE
    ##  $ RD      : logi TRUE
    ##  $ RA      : logi TRUE
    ##  $ AD      : logi TRUE
    ##  $ CD      : logi FALSE
    ##  $ Question:'data.frame':    1 obs. of  2 variables:
    ##   ..$ name: chr "example.com."
    ##   ..$ type: int 1
    ##  $ Answer  :'data.frame':    1 obs. of  4 variables:
    ##   ..$ name: chr "example.com."
    ##   ..$ type: int 1
    ##   ..$ TTL : int 3574
    ##   ..$ data: chr "93.184.216.34"

``` r
str(query("microsoft.com", "MX"))
```

    ## List of 8
    ##  $ Status  : int 0
    ##  $ TC      : logi FALSE
    ##  $ RD      : logi TRUE
    ##  $ RA      : logi TRUE
    ##  $ AD      : logi FALSE
    ##  $ CD      : logi FALSE
    ##  $ Question:'data.frame':    1 obs. of  2 variables:
    ##   ..$ name: chr "microsoft.com."
    ##   ..$ type: int 15
    ##  $ Answer  :'data.frame':    1 obs. of  4 variables:
    ##   ..$ name: chr "microsoft.com."
    ##   ..$ type: int 15
    ##   ..$ TTL : int 2381
    ##   ..$ data: chr "10 microsoft-com.mail.protection.outlook.com."

``` r
# query("google-public-dns-a.google.com", "TXT") # CURRENTLY BROKEN ON CLOUDFLARE'S END

str(query("apple.com"))
```

    ## List of 8
    ##  $ Status  : int 0
    ##  $ TC      : logi FALSE
    ##  $ RD      : logi TRUE
    ##  $ RA      : logi TRUE
    ##  $ AD      : logi FALSE
    ##  $ CD      : logi FALSE
    ##  $ Question:'data.frame':    1 obs. of  2 variables:
    ##   ..$ name: chr "apple.com."
    ##   ..$ type: int 1
    ##  $ Answer  :'data.frame':    3 obs. of  4 variables:
    ##   ..$ name: chr [1:3] "apple.com." "apple.com." "apple.com."
    ##   ..$ type: int [1:3] 1 1 1
    ##   ..$ TTL : int [1:3] 3005 3005 3005
    ##   ..$ data: chr [1:3] "17.142.160.59" "17.172.224.47" "17.178.96.59"

``` r
str(query("17.142.160.59", "PTR"))
```

    ## List of 8
    ##  $ Status   : int 3
    ##  $ TC       : logi FALSE
    ##  $ RD       : logi TRUE
    ##  $ RA       : logi TRUE
    ##  $ AD       : logi TRUE
    ##  $ CD       : logi FALSE
    ##  $ Question :'data.frame':   1 obs. of  2 variables:
    ##   ..$ name: chr "17.142.160.59."
    ##   ..$ type: int 12
    ##  $ Authority:'data.frame':   1 obs. of  4 variables:
    ##   ..$ name: chr "."
    ##   ..$ type: int 6
    ##   ..$ TTL : int 3592
    ##   ..$ data: chr "a.root-servers.net. nstld.verisign-grs.com. 2018040101 1800 900 604800 86400"

#' Query 'Cloudflare' Domain Name System ('DNS') Servers over 'HTTPS'
#'
#' Domain Name System ('DNS') queries are generally perfomed by operating
#' system calls when browsing the internet or making other network connectios. DNS
#' over 'HTTPS' services offer more local confidentiality and some 'DNS' providers
#' like Cloudflare offer (<https://developers.cloudflare.com/1.1.1.1/dns-over-https/json-format/>)
#' an 'API'-like service along with other privacy-enabled 'DNS' offerings. Tools are
#' provided to query this 'DNS' 'API'.

#' @md
#' @name dnsflare
#' @docType package
#' @author Bob Rudis (bob@@rud.is)
#' @import httr
#' @importFrom jsonlite fromJSON
NULL

#' Cloudflare upstream source ranges used to query upstream DNS providers
#'
#' @note makes a network connection to Cloudflare to retrieve the list.
#'     Consider 'memoise'-ing it if you use it in "production".
#' @export
#' @examples
#' cf_upstream_ipv4()
cf_upstream_ipv4 <- function() {
  readLines("https://www.cloudflare.com/ips-v4")
}

#' @rdname cf_upstream_ipv4
#' @export
#' @examples
#' cf_upstream_ipv6()
cf_upstream_ipv6 <- function() {
  readLines("https://www.cloudflare.com/ips-v6")
}
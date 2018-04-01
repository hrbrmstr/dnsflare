#' Make a single DNS query
#'
#' @md
#' @note Cloudfare does not support `ANY` queries.
#' @param name query name (e.g. `example.com`)
#' @param type query type (e.g. `AAAA`). Valid types can be found [here](https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-4)
#'        and perused in the [valid_dns_types] built-in data frame. Defaults to "`A`". _MUST_ be alpha-record, not numeric.
#' @export
#' @return a `list`` with the following field meanings:
#' - `Status`: The Response Code of the DNS Query. These are defined here: <https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6>
#' - `TC`: If true, it means the truncated bit was set. This happens when the DNS answer is larger than a single UDP or TCP packet. TC will almost always be false with Cloudflare DNS over HTTPS because Cloudflare supports the maximum response size.
#' - `RD`: If true, it means the Recursive Desired bit was set. This is always set to true for Cloudflare DNS over HTTPS.
#' - `RA`: If true, it means the Recursion Available bit was set. This is always set to true for Cloudflare DNS over HTTPS.
#' - `AD`: If true, it means that every record in the answer was verified with DNSSEC.
#' - `CD`: If true, the client asked to disable DNSSEC validation. In this case, Cloudflare will still fetch the DNSSEC-related records, but it will not attempt to validate the records.
#' - `Question`: a data frame with the `name` and `type` (numeric form) from the original query
#' - `Answer`: a data frame with the `name` of the record owner, `type` of record (numeric form), the `TTL` number of seconds the answer can be stored in cache before it is considered stale and the `answer` data (whhich is contingent on the question being asked)
#' @examples
#' query("rud.is")
#' query("example.com", "A")
#' query("microsoft.com", "MX")
#' # query("google-public-dns-a.google.com", "TXT") # CURRENTLY BROKEN ON CLOUDFLARE'S END
#' query("apple.com")
#' query("17.142.160.59", "PTR")
query <- function(name, type = "A") {

  name <- name[1]
  type <- toupper(type[1])

  if (!(type %in% valid_dns_types$type)) stop("Not a valid DNS type", call.=FALSE)
  if (type == "ANY") stop("Not a valid DNS type", call.=FALSE)

  if (grepl(ipv4_regex, name)) {
    .tmp <- rev(unlist(strsplit(name, "\\.")))
    name <- paste0(c(.tmp, "in-addr.arpa."), sep = "", collapse = ".")
  }

  httr::GET(
    url = "https://cloudflare-dns.com/dns-query",
    query = list (
      ct = "application/dns-json",
      name = name,
      type = type
    ),
    httr::content_type_json(),
    httr::user_agent("#rstats dnsflare 0.1.0 / <https://github.com/hrbrmstr/dnsflare>")
  ) -> res

  httr::stop_for_status(res)

  res <- httr::content(res, as="text", encoding="UTF-8")
  res <- jsonlite::fromJSON(res)

  class(res) <- c("cf_dns_result")

  res

}

#' S3 Print method for cf_dns_result
#'
#' @param x cf_dns_result
#' @param ... ignored
#' @export
print.cf_dns_result <- function(x, ...) {

  y <- x

  y$Question$type <- as.character(y$Question$type)
  y$Answer$type <- as.character(y$Answer$type)

  y$Question <- merge(y$Question, .vdt, by="type")
  y$Answer <- merge(y$Answer, .vdt, by="type")

  yst <- .query_status[.query_status$Status == y$Status,]$Description

  xtra <- c(sprintf("Status: %s", yst))
  if (y$TC) xtra <- append(xtra, "Truncated")
  if (y$RD) xtra <- append(xtra, "Recursive Desired")
  if (y$RA) xtra <- append(xtra, "Recursive Available")
  if (y$AD) xtra <- append(xtra, "DNSSEC Verified")
  if (y$CD) xtra <- append(xtra, "Client DNSSEC Disabled")

  cat("Question:\n\n", sep="")
  print(as.data.frame(y$Question))

  cat("\nAnswer:\n\n", sep="")
  print(as.data.frame(y$Answer))

  cat("\n", paste0(xtra, collapse=" | "), sep="")

  invisible(x)

}

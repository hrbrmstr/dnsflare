structure(list(Status = c("0", "1", "2", "3", "4", "5", "6",
"7", "8", "9", "9", "10", "11-15", "16", "16", "17", "18", "19",
"20", "21", "22", "23", "24-3840", "3841-4095", "4096-65534",
"65535"), Description = c("No Error", "Format Error", "Server Failure",
"Non-Existent Domain", "Not Implemented", "Query Refused", "Name Exists when it should not",
"RR Set Exists when it should not", "RR Set that should exist does not",
"Server Not Authoritative for zone", "Not Authorized", "Name not contained in zone",
NA, "Bad OPT Version", "TSIG Signature Failure", "Key not recognized",
"Signature out of time window", "Bad TKEY Mode", "Duplicate key name",
"Algorithm not supported", "Bad Truncation", "Bad/missing Server Cookie",
NA, NA, NA, NA)), row.names = c(NA, -26L), class = c("tbl_df",
"tbl", "data.frame"), spec = structure(list(cols = structure(list(
    RCODE = structure(list(), class = c("collector_character",
    "collector")), Name = structure(list(), class = c("collector_character",
    "collector")), Description = structure(list(), class = c("collector_character",
    "collector")), Reference = structure(list(), class = c("collector_character",
    "collector"))), .Names = c("RCODE", "Name", "Description",
"Reference")), default = structure(list(), class = c("collector_guess",
"collector"))), .Names = c("cols", "default"), class = "col_spec"), .Names = c("Status",
"Description")) -> .query_status

ipv4_regex <- "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"

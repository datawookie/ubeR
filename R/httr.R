# TODO: Must be a better way to code this!!!
#
buildArguments <- function(latitude = NULL, longitude = NULL, start_latitude = NULL, start_longitude = NULL,
                           end_latitude = NULL, end_longitude = NULL, seat_count = NULL, product_id = NULL) {
  sapply(names(formals()), function(arg) {
    value <- get(arg)
    ifelse(length(value) > 0, value, NA)
  }, simplify = FALSE)
}

GET <- function(url, query = NULL) {
  # httr::GET(url, query = query, httr::add_headers(Authorization = paste("Token", get_serverid())))
  httr::GET(url, query = query, httr::config(token = get_oauth_token()))
}

callAPI = function(cmd, version, params = NULL, method = "GET") {
  url = getEndpoint(cmd, version)

  params = params[!sapply(params, is.na)]

  if (method == "POST") {
    stop("POST not yet implemented.")
  } else {
    if (is.null(params)) {
      query = NULL
    } else {
      query = lapply(params, function(x) URLencode(as.character(x)))
    }
    return(httr::content(GET(url, query = query)))
  }
}

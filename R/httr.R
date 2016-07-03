# TODO: Must be a better way to code this!!!
#
# One option would be to use as.list(match.call())[-1] from within each function, which returns
# the formal arguments as a list.
#
buildArguments <- function(latitude = NULL, longitude = NULL, start_latitude = NULL, start_longitude = NULL,
                           end_latitude = NULL, end_longitude = NULL, seat_count = NULL, product_id = NULL,
                           start_address = NULL, end_address = NULL) {
  sapply(names(formals()), function(arg) {
    value <- get(arg)
    ifelse(length(value) > 0, value, NA)
  }, simplify = FALSE)
}

GET <- function(url, query = NULL) {
  # httr::GET(url, query = query, httr::add_headers(Authorization = paste("Token", get_serverid())))
  httr::GET(url, httr::config(token = get_oauth_token()), query = query)
}

POST <- function(url, body = NULL) {
  httr::POST(url, httr::config(token = get_oauth_token()), encode = "json", body = body)
}

DELETE <- function(url, body = NULL) {
  httr::DELETE(url, httr::config(token = get_oauth_token()), encode = "json", body = body)
}

callAPI = function(cmd, version, params = NULL, method = "GET") {
  url = getEndpoint(cmd, version)

  params = params[!sapply(params, is.na)]

  if (method == "POST") {
    response = try(POST(url, body = params), silent = TRUE)
    print(response)
  } else if (method == "GET") {
    if (is.null(params)) {
      query = NULL
    } else {
      query = lapply(params, function(x) URLencode(as.character(x)))
    }
    response = GET(url, query = query)
  } else if (method == "DELETE") {
    response = DELETE(url, body = params)
  } else {
    stop("Unknown HTTP method.", call = FALSE)
  }
  httr::content(response)
}

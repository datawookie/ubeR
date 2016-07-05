parseParameters <- function(call) {
  params = as.list(call)

  if ("start_address" %in% names(params)) {
    geo = suppressMessages(geocode(params$start_address))
    params$start_latitude = geo$lat
    params$start_longitude = geo$lon
  }
  if ("end_address" %in% names(params)) {
    geo = suppressMessages(geocode(params$end_address))
    params$end_latitude = geo$lat
    params$end_longitude = geo$lon
  }
  #
  params$start_latitude  = check.latitude(params$start_latitude)
  params$end_latitude    = check.latitude(params$end_latitude)
  params$start_longitude = check.longitude(params$start_longitude)
  params$end_longitude   = check.longitude(params$end_longitude)
  #
  params
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

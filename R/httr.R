#' Parse parameters for API requests
#'
#' Provide consistent parsing of API request parameters.
#'
#' @keywords internal
parseParameters <- function(call) {
  params = as.list(call)

  # Addresses take precedence over coordinates if both are provided.
  #
  if (!is.null(params$start_address)) {
    geo = suppressMessages(geocode(params$start_address))
    params$start_latitude = geo$lat
    params$start_longitude = geo$lon
  }
  if (!is.null(params$end_address)) {
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
  params = params[!sapply(params, is.null)]
  #
  params
}

#' Send GET request to a server
#'
#' A wrapper around httr::GET().
#'
#' @keywords internal
GET <- function(url, query = NULL) {
  httr::GET(url, httr::config(token = get_oauth_token()), query = query)
}

#' Send POST request to a server
#'
#' A wrapper around httr::POST().
#'
#' @keywords internal
POST <- function(url, body = NULL) {
  httr::POST(url, httr::config(token = get_oauth_token()), encode = "json", body = body)
}

#' Send PUT request to a server
#'
#' A wrapper around httr::PUT().
#'
#' @keywords internal
PUT <- function(url, body = NULL) {
  httr::PUT(url, httr::config(token = get_oauth_token()), encode = "json", body = body)
}

#' Send DELETE request to a server
#'
#' A wrapper around httr::DELETE().
#'
#' @keywords internal
DELETE <- function(url, body = NULL) {
  httr::DELETE(url, httr::config(token = get_oauth_token()), encode = "json", body = body)
}

#' Handle interactions with the Uber API
#'
#' @param cmd Specifies the endpoint.
#' @param version The version of the API for particular endpoint.
#' @param params Data passed with request.
#' @param method Type of request.
#'
#' @keywords internal
#' @import httr
#' @import jsonlite
#' @import utils
callAPI <- function(cmd, version, params = NULL, method = "GET") {
  url = getEndpoint(cmd, version)

  # Check whether endpoint is accessible.
  #
  check.url = try(httr::HEAD(url), silent = TRUE)
  #
  if (class(check.url) == "try-error") stop("Unable to reach ", url, ". Check network connection?", call. = FALSE)

  params = params[!sapply(params, is.na)]

  if (method == "POST") {
    response = try(POST(url, body = params), silent = TRUE)
    # print(response)
  } else if (method == "PUT") {
    response = try(PUT(url, body = params), silent = TRUE)
    # print(response)
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
  #
  # This provides better output format than letting httr::content() do the parsing.
  #
  jsonlite::fromJSON(httr::content(response, as = "text", encoding = "UTF-8"))
}

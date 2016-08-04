#' https://developer.uber.com/docs/rides/api/v1-requests
#'
#' Requires an OAuth 2.0 token with the request scope.
#'
#' @param start_latitude
#' @param start_longitude
#' @param end_latitude
#' @param end_longitude
#' @param start_address
#' @param end_address
#' @export
uber_requests <- function(start_latitude = NULL, start_longitude = NULL, end_latitude = NULL, end_longitude = NULL, start_address = NULL, end_address = NULL) {
  callAPI("requests", 1, method = "POST", params = parseParameters(environment()))
}

#' https://developer.uber.com/docs/rides/api/v1-requests-estimate
#'
#' Requires an OAuth 2.0 token with the request scope
#'
#' @export
uber_requests_estimate <- function(start_latitude = NULL, start_longitude = NULL, end_latitude = NULL, end_longitude = NULL) {
  response <- callAPI("requests/estimate", 1, method = "POST", params = parseParameters(environment()))
  #
  response$price <- with(response$price,
                         cbind(bind_rows(fare_breakdown), surge_multiplier, currency_code)
                         )
  #
  response
}

#' https://developer.uber.com/docs/rides/api/v1-requests-current
#'
#' Requires an OAuth 2.0 token with the all_trips or request scope
#'
#' @export
uber_requests_current <- function() {
  callAPI("requests/current", 1)
}

#' https://developer.uber.com/docs/rides/api/v1-requests-current-delete
#'
#' Requires an OAuth 2.0 token with the request scope
#'
#' @export
uber_requests_current_delete <- function() {
  callAPI("requests/current", 1, method = "DELETE")
}

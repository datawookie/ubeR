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
  if (!is.null(start_address)) {
    start_geo = geocode(start_address)
    start_latitude = start_geo$lat
    start_longitude = start_geo$lon
  }
  if (!is.null(end_address)) {
    end_geo = geocode(end_address)
    end_latitude = end_geo$lat
    end_longitude = end_geo$lon
  }
  params = buildArguments(start_latitude = start_latitude, start_longitude = start_longitude,
                          end_latitude = end_latitude, end_longitude = end_longitude)
  callAPI("requests", 1, method = "POST", params = params)
}

#' https://developer.uber.com/docs/rides/api/v1-requests-estimate
#'
#' Requires an OAuth 2.0 token with the request scope
#'
#' @export
uber_requests_estimate <- function(start_latitude = NULL, start_longitude = NULL, end_latitude = NULL, end_longitude = NULL) {
  params = buildArguments(start_latitude = start_latitude, start_longitude = start_longitude,
                          end_latitude = end_latitude, end_longitude = end_longitude)
  callAPI("requests/estimate", 1, method = "POST", params = params)
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

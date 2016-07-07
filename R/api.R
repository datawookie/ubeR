#' It's possible that a home location will need to be set via the Uber application before this will work.
#'
#' https://developer.uber.com/docs/rides/api/v1-places-get
#'
#' Requires an OAuth 2.0 token with the places scope.
#'
#' @param place Either "home" or "work".
#' @export
uber_places_get <- function(place_id = c("home", "work")) {
  place_id = place_id[1]
  callAPI(paste("places", place_id, sep = "/"), 1, method = "GET", params = NULL)
}

#' https://developer.uber.com/docs/rides/api/v1-places-put
#'
#' Requires an OAuth 2.0 token with the places scope.
#'
#' @param place Either "home" or "work".
#' @export
uber_places_put <- function(place_id = c("home", "work"), address) {
  place_id = place_id[1]
  callAPI(paste("places", place_id, sep = "/"), 1, method = "PUT", params = list(address = address))
}

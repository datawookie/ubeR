#' https://developer.uber.com/docs/rides/api/v1-estimates-price
#' @export
uber_estimate_price <- function(start_latitude, start_longitude, end_latitude, end_longitude, seat_count = NULL) {
  estimates = callAPI("estimates/price", 1, method = "GET", params = parseParameters(environment()))

  bind_rows(lapply(estimates$prices, function(estimate) {
    data.frame(t(unlist(estimate)), stringsAsFactors = FALSE)
  }))
}

#' https://developer.uber.com/docs/rides/api/v1-estimates-time
#' @export
uber_estimate_time <- function(start_latitude, start_longitude, product_id = NULL) {
  estimates = callAPI("estimates/time", 1, method = "GET", params = parseParameters(environment()))

  bind_rows(lapply(estimates$times, function(estimate) {
    data.frame(t(unlist(estimate)), stringsAsFactors = FALSE)
  }))
}

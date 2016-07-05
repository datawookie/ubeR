#' https://developer.uber.com/docs/rides/api/v1-estimates-price
#' @export
estimate_price <- function(start_latitude, start_longitude, end_latitude, end_longitude, seat_count = NULL) {
  seat_count = as.integer(seat_count)

  estimates = callAPI("estimates/price", 1, , params = parseParameters(environment()))

 bind_rows(lapply(estimates$prices, function(estimate) {
    data.frame(t(unlist(estimate)), stringsAsFactors = FALSE)
  }))
}

#' https://developer.uber.com/docs/rides/api/v1-estimates-time
#' @export
estimate_time <- function(start_latitude, start_longitude, product_id = NULL) {
  start_latitude = check.latitude(start_latitude)
  start_longitude = check.longitude(start_longitude)
  #
  product_id = as.character(product_id)

  estimates = callAPI("estimates/time", 1, buildArguments(start_latitude = start_latitude, start_longitude = start_longitude, product_id = product_id))

  bind_rows(lapply(estimates$times, function(estimate) {
    data.frame(t(unlist(estimate)), stringsAsFactors = FALSE)
  }))
}

#' https://developer.uber.com/docs/rides/api/v1-estimates-price
#' @export
estimate_price <- function(start_latitude, start_longitude, end_latitude, end_longitude, seat_count = NA) {
  start_latitude = as.numeric(start_latitude)
  start_longitude = as.numeric(start_longitude)
  end_latitude = as.numeric(end_latitude)
  end_longitude = as.numeric(end_longitude)
  #
  seat_count = as.integer(seat_count)

  # TODO: WRITE SYSTEMATIC FUNCTION FOR CHECKING LATITUDE/LONGITUDE
  #
  # if (!is.na(longitude) && (longitude > 180 || longitude < -180)) {
  #   stop('Longitude must be in range [180,-180].')
  # }
  # if (!is.na(latitude) && (latitude > 90 || latitude < -90)) {
  #   stop('Latitude must be in range [90.0,-90.0].')
  # }

  estimates = callAPI("estimates/price", buildArguments(start_latitude = start_latitude, start_longitude = start_longitude,
                                                        end_latitude = end_latitude, end_longitude = end_longitude, seat_count = seat_count))

 bind_rows(lapply(estimates$prices, function(estimate) {
    data.frame(t(unlist(estimate)), stringsAsFactors = FALSE)
  }))
}

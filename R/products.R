#' https://developer.uber.com/docs/rides/api/v1-products
#' @export
products <- function(latitude, longitude) {
  latitude = as.numeric(latitude)
  longitude = as.numeric(longitude)

  if ((longitude > 180) || (longitude < -180)) {
    stop('Longitude must be in range [180,-180].')
  }
  if ((latitude > 90)||(latitude < -90)) {
    stop('Latitude must be in range [90.0,-90.0].')
  }

  callAPI("products", buildArguments(latitude = 37.7759792, longitude = -122.41823))
}

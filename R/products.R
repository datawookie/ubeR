#' https://developer.uber.com/docs/rides/api/v1-products
#' @export
products <- function(latitude = NA, longitude = NA, product_id = NA) {
  if (any(is.na(c(latitude, longitude))) && is.na(product_id))
    stop("Either both latitude and longitude or product_id must be specified.")
  #
  latitude = as.numeric(latitude)
  longitude = as.numeric(longitude)
  #
  product_id = as.character(product_id)

  if (!is.na(longitude) && (longitude > 180 || longitude < -180)) {
    stop('Longitude must be in range [180,-180].')
  }
  if (!is.na(latitude) && (latitude > 90 || latitude < -90)) {
    stop('Latitude must be in range [90.0,-90.0].')
  }

  if (is.na(product_id)) {
    rides = callAPI("products", buildArguments(latitude = latitude, longitude = longitude))$products
  } else {
    rides = list(callAPI(paste("products", product_id, sep = "/")))
  }

  rides = lapply(rides, function(ride) {
    data.frame(t(unlist(ride)), stringsAsFactors = FALSE)
  })
  bind_rows(rides)
}

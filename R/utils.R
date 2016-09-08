check.latitude <- function(latitude) {
  if (is.null(latitude) || is.na(latitude)) return(latitude)
  latitude = as.numeric(latitude)
  if ((latitude > 90 || latitude < -90)) {
    stop('Latitude must be in range [90.0,-90.0].')
  } else return(latitude)
}

check.longitude <- function(longitude) {
  if (is.null(longitude) || is.na(longitude)) return(longitude)
  longitude = as.numeric(longitude)
  if (!is.na(longitude) && (longitude > 180 || longitude < -180)) {
    stop('Longitude must be in range [180,-180].')
  } else return(longitude)
}

getEndpoint <- function(cmd, version = 1) {
  # paste("https://api.uber.com/v", version, '/', cmd, sep='')
  #
  # Use the API sandbox (https://developer.uber.com/docs/rides/sandbox)
  #
  paste("https://sandbox-api.uber.com/v", version, '/', cmd, sep='')
}

#' @import ggmap
#' @importFrom stats na.omit
geocode <- function(location) {
  position <- na.omit(suppressWarnings(suppressMessages(ggmap::geocode(location))))
  if (nrow(position) == 0) {
    stop(sprintf("Unable to find location '%s'.", location), call. = FALSE)
  }
  position
}

nullToNA <- function(x) {
  x[sapply(x, is.null)] <- NA
  return(x)
}

